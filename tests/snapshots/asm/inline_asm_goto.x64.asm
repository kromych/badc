
inline_asm_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<take_or_fall>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq

<pick>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x14, %eax
               	retq

<count_down>:
               	xorl	%eax, %eax
               	incq	%rax
               	decq	%rdi
               	movslq	%edi, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	retq

<same_target>:
               	movslq	%edi, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x7, %eax
               	retq

<splice_then_goto>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq

<phi_merge>:
               	movslq	%edi, %rdi
               	movl	$0x5, %eax
               	cmpl	$0xa, %edi
               	jle	<addr>
               	movl	$0x9, %eax
               	retq
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>

<main>:
               	movl	$0x1, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	je	<addr>
               	jmp	<addr>
               	movl	$0x3, %r10d
               	testl	%r10d, %r10d
               	je	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	incq	%rcx
               	decq	%rax
               	movslq	%eax, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %r10d
               	cmpl	$0x1, %r10d
               	jg	<addr>
               	movl	$0x2, %r10d
               	cmpl	$0x1, %r10d
               	jg	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x3, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2, %eax
               	retq
