
va_copy_under_pressure.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	movq	%rdi, -0x190(%rbp)
               	movq	%rsi, -0x188(%rbp)
               	movq	%rdx, -0x180(%rbp)
               	movq	%rcx, -0x178(%rbp)
               	movq	%r8, -0x170(%rbp)
               	movq	%r9, -0x168(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0x160(%rbp,%riz)
               	movsd	%xmm1, -0x150(%rbp,%riz)
               	movsd	%xmm2, -0x140(%rbp,%riz)
               	movsd	%xmm3, -0x130(%rbp,%riz)
               	movsd	%xmm4, -0x120(%rbp,%riz)
               	movsd	%xmm5, -0x110(%rbp,%riz)
               	movsd	%xmm6, -0x100(%rbp,%riz)
               	movsd	%xmm7, -0xf0(%rbp,%riz)
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	-0x190(%rbp), %rax
               	leaq	(%rax,%rax,2), %rcx
               	leaq	0xb(%rax), %rdx
               	imulq	$0x7, %rax, %rsi
               	leaq	-0x2(%rax), %rdi
               	imulq	$0xd, %rax, %r8
               	leaq	0x1d(%rax), %r9
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	leaq	0x29(%rax), %r12
               	leaq	(%rax,%rax,8), %r13
               	leaq	0x35(%rax), %r14
               	leaq	(%rax,%rax,4), %r15
               	leaq	0x3d(%rax), %r10
               	movq	%r10, 0x108(%rsp)
               	imulq	$0xf, %rax, %r10
               	movq	%r10, 0x100(%rsp)
               	addq	$0x3, %rax
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0xf8(%rsp)
               	leaq	-0x190(%rbp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r11
               	movl	$0x8, (%r11)
               	movl	$0x30, 0x4(%r11)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%r11)
               	leaq	-0x190(%rbp), %r10
               	movq	%r10, 0x10(%r11)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0xf8(%rsp)
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf0(%rsp), %r11
               	movq	0xf8(%rsp), %r10
               	pushq	%rax
               	movq	(%r11), %rax
               	movq	%rax, (%r10)
               	movq	0x8(%r11), %rax
               	movq	%rax, 0x8(%r10)
               	movq	0x10(%r11), %rax
               	movq	%rax, 0x10(%r10)
               	popq	%rax
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf8(%rsp), %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, 0xf8(%rsp)
               	movq	0xf8(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0xf8(%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf0(%rsp), %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf0(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0xf0(%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0xe8(%rsp)
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0xe8(%rsp)
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	%rbx, %rcx
               	addq	%r12, %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x108(%rsp), %rcx
               	addq	0x100(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	0xf8(%rsp), %rax
               	addq	0xf0(%rsp), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x1c0, %rsp            # imm = 0x1C0
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x160, %rax            # imm = 0x160
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
