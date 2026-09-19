
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
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq

<pick>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	$0x14, %eax
               	retq

<count_down>:
               	xorl	%ecx, %ecx
               	incq	%rcx
               	decq	%rdi
               	movslq	%edi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq

<same_target>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	testl	%eax, %eax
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
               	movl	$0x5, %ecx
               	cmpl	$0xa, %edi
               	jle	<addr>
               	movl	$0x9, %ecx
               	movq	%rcx, %rax
               	retq
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	jmp	<addr>

<main>:
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	incq	%rdx
               	decq	%rcx
               	movslq	%ecx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x5, %ecx
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	$0x5, %ecx
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
