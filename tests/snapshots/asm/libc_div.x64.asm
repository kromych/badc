
libc_div.x64:	file format elf64-x86-64

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

<rti>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<rtl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<rtll>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x11, %edi
               	callq	<addr>
               	movslq	%eax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rcx
               	movq	%rbx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	movq	%rbx, %rcx
               	subq	%rax, %rcx
               	cmpl	$0x3, %esi
               	jne	<addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x11, %rdi
               	callq	<addr>
               	movslq	%eax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rsi
               	movq	%rbx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	movq	%rcx, %rdx
               	imulq	%rsi, %rdx
               	movq	%rbx, %rax
               	subq	%rdx, %rax
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	movq	%rbx, %rcx
               	subq	%rax, %rcx
               	cmpq	$0xe, %rsi
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rax
               	cqto
               	idivq	%rcx
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	imulq	%rcx, %rax
               	movq	%rbx, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x14d, %rsi            # imm = 0x14D
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
