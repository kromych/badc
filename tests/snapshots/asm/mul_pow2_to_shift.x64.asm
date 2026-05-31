
mul_pow2_to_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400677 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r14, 0x8(%rsp)
               	movq	%r15, 0x10(%rsp)
               	movl	$0x7, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r8
               	shlq	$0x1, %r8
               	movslq	%r8d, %r8
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movslq	%edi, %rdi
               	movq	%r9, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %rdx
               	shlq	$0x4, %rdx
               	movslq	%edx, %rdx
               	shlq	$0xa, %r9
               	movslq	%r9d, %r9
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	andq	%r11, %rcx
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	shlq	$0x8, %rcx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	movq	%r11, %r15
               	shlq	$0x5, %r15
               	shlq	$0x10, %r11
               	movslq	%r8d, %r8
               	movslq	%edi, %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movslq	%esi, %rsi
               	addq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%edx, %rdx
               	addq	%rdx, %r8
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	addq	%rax, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rcx
               	addq	%rcx, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r8
               	addq	%r15, %r8
               	movq	%r8, %rbx
               	addq	%r11, %rbx
               	leaq	0xfc78(%rip), %r15      # 0x410150
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40067d <printf>
               	movslq	%eax, %rax
               	cmpq	$0x724c0, %rbx          # imm = 0x724C0
               	jne	0x400504 <.text+0x244>
               	xorq	%rax, %rax
               	movq	%rax, -0x88(%rbp)
               	jmp	0x400515 <.text+0x255>
               	movl	$0x1, %eax
               	movq	%rax, -0x88(%rbp)
               	jmp	0x400515 <.text+0x255>
               	movq	-0x88(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
