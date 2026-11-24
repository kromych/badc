
libc_div.x64:	file format elf64-x86-64

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

<rti>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<rtl>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<rtll>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movl	$0x11, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	%ebx, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %rsi
               	imulq	%rsi, %rcx
               	subq	%rcx, %rbx
               	cmpl	$0x3, %esi
               	jne	<addr>
               	cmpl	$0x2, %ebx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	movq	$-0x11, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	%ebx, %eax
               	cltd
               	idivl	%esi
               	movq	%rax, %rcx
               	imulq	%rcx, %rsi
               	subq	%rsi, %rbx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	cmpl	$-0x2, %ebx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	leaq	(%rcx,%rcx,4), %rax
               	addq	%rbx, %rax
               	cmpl	$-0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
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
               	imulq	%rsi, %rcx
               	subq	%rcx, %rbx
               	cmpq	$0xe, %rsi
               	jne	<addr>
               	cmpq	$0x2, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
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
               	imulq	%rsi, %rcx
               	subq	%rcx, %rbx
               	cmpq	$0x14d, %rsi            # imm = 0x14D
               	jne	<addr>
               	cmpq	$0x1, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
