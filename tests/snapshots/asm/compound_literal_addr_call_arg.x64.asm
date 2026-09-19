
compound_literal_addr_call_arg.x64:	file format elf64-x86-64

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

<take16>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rsi), %rax
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	0x8(%rsi), %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rsi, (%rdx)
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	<rip>, %r12
               	leaq	-0x88(%rbp), %rdx
               	movq	%rdx, (%r12)
               	leaq	<rip>, %rbx
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, (%rbx)
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movq	(%r12), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	movq	(%r12), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	movq	(%r12), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%rbx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, (%rsi)
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x80(%rbp), %rcx
               	movq	(%r12), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x80(%rbp), %rsi
               	movq	(%r12), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rcx
               	movq	(%r12), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	<rip>, %rax
               	leaq	-0x80(%rbp), %rdx
               	movq	(%r12), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	(%rax), %rsi
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	0x8(%rax), %rsi
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, (%rdx)
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	(%rbx), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	(%rcx), %rdx
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	0x8(%rcx), %rdx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rcx, (%rsi)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rdx, (%rsi)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	movq	%rsi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	(%rbx), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x4444444444444444, %r11 # imm = 0x4444444444444444
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rcx, (%rdx)
               	jmp	<addr>
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %rsi
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rcx, (%rdx)
               	jmp	<addr>
               	movq	(%rbx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rcx, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
