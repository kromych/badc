
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
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	<rip>, %rdx
               	leaq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx)
               	leaq	<rip>, %rdi
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, (%rdi)
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x80(%rbp), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rcx, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	cmpq	%r8, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rax
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %r8
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movq	(%rdi), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x80(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rcx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	cmpq	%r8, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x80(%rbp), %rsi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	<rip>, %rcx
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
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
               	movq	%rcx, (%rax)
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movq	(%rax), %rcx
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movq	%rax, (%rsi)
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	%rcx, (%rdx)
               	jmp	<addr>
               	movsd	(%rcx), %xmm0
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rcx), %xmm0
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movq	%rcx, (%rdx)
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
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
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x4444444444444444, %r11 # imm = 0x4444444444444444
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	%rax, (%rsi)
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	(%rdi), %rdx
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
