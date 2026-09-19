
alloca_call_args.x64:	file format elf64-x86-64

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

<sum10>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x100000, %eax         # imm = 0x100000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movl	$0x7, %edx
               	xorl	%eax, %eax
               	movb	%dl, (%rcx,%rax)
               	addq	$0x1000, %rax           # imm = 0x1000
               	cmpl	$0x100000, %eax         # imm = 0x100000
               	jl	<addr>
               	leaq	0xfffff(%rcx), %rax
               	movb	$0x8, (%rax)
               	movsbq	(%rcx), %rax
               	leaq	0x8(%rax), %rbx
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	movl	$0x6, %r12d
               	movl	$0x8, %r13d
               	movl	$0x9, %r14d
               	movl	$0xa, %r15d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rdx, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rcx, %rdx
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movq	%r12, %r9
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpl	$0xf, %ebx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
