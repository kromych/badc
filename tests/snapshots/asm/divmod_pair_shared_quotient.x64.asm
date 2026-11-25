
divmod_pair_shared_quotient.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<check_uint>:
               	movq	%rdx, %r9
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rax, %r8
               	cmpl	%r9d, %r8d
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%r8, %rax
               	imulq	%rsi, %rax
               	movq	%rdi, %r10
               	subq	%rax, %r10
               	cmpl	%ecx, %r10d
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	addq	%r8, %r10
               	addq	%r9, %rcx
               	cmpl	%ecx, %r10d
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	%ecx, %r10d
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	imulq	%rsi, %r8
               	movq	%rdi, %rax
               	subq	%r8, %rax
               	addq	%r8, %rax
               	cmpl	%edi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	movl	(%rdx), %edi
               	movl	0x4(%rdx), %r8d
               	movl	0x8(%rdx), %r9d
               	movl	0xc(%rdx), %r10d
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %rsi
               	cmpl	%r9d, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	nop
               	jmp	<addr>
               	movq	%rsi, %rbx
               	imulq	%r8, %rbx
               	movq	%rdi, %r11
               	subq	%rbx, %r11
               	cmpl	%r10d, %r11d
               	je	<addr>
               	movl	$0x2, %eax
               	nopl	(%rax)
               	jmp	<addr>
               	leaq	(%rsi,%r11), %rax
               	addq	%r10, %r9
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rdi, %rax
               	subq	%rbx, %rax
               	addq	%rsi, %rax
               	nop
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	imulq	%r8, %rsi
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	addq	%rsi, %rax
               	nopl	(%rax)
               	cmpl	%edi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	incq	%rcx
               	cmpl	$0xc, %ecx
               	jb	<addr>
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x1e, %rax
               	popq	%rbx
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0x7, %esi
               	movl	$0x24924924, %edx       # imm = 0x24924924
               	movl	$0x3, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	xorl	%edx, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	xorl	%ecx, %ecx
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rsi
               	subq	%rsi, %rax
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x19, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	addq	$0xa, %rax
               	popq	%rbx
               	retq
