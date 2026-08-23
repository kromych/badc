
variadic_hfa_struct_arg.x64:	file format elf64-x86-64

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

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rcx
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	-0x18(%rbp), %rcx
               	movsd	(%rax,%riz), %xmm0
               	leaq	-0x28(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rsi
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rsi,%riz)
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rsi,%riz)
               	movl	$0x1, %ebx
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movsd	0x8(%r10,%riz), %xmm1
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movabsq	$0x400e000000000000, %rax # imm = 0x400E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
