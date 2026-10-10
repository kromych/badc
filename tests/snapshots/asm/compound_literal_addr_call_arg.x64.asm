
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	leaq	-0x88(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rsi      # <addr>
               	leaq	-0x80(%rbp), %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rax)
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	(%rsi), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rsi
               	leaq	<rip>, %rdi      # <addr>
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movabsq	$0x4444444444444444, %r11 # imm = 0x4444444444444444
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x80(%rbp), %rdx
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
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rsi
               	leaq	<rip>, %rdi      # <addr>
               	movq	(%rdi), %r8
               	cmpq	%r8, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %r8       # <addr>
               	movq	(%r8), %r8
               	cmpq	%r8, %rsi
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %r8
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	(%rdi), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rdi
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, -0x80(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rdi      # <addr>
               	movq	(%rdi), %r8
               	cmpq	%r8, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rax, -0x80(%rbp)
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movq	(%rdi), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	-0x78(%rbp), %rax
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	-0x70(%rbp), %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	%rcx, -0x80(%rbp)
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	<rip>, %rax      # <addr>
               	leaq	<rip>, %r8       # <addr>
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	(%rax), %rdx
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%rax, -0x80(%rbp)
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
