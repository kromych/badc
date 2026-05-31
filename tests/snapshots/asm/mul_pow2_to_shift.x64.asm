
mul_pow2_to_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
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
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4006b7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	movq	%r9, %rcx
               	shlq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movq	%r9, %rax
               	shlq	$0x8, %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	movq	%r11, %rax
               	shlq	$0x5, %rax
               	movq	%r11, %r14
               	shlq	$0x10, %r14
               	movslq	%r8d, %r11
               	movslq	%edi, %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movslq	%esi, %r8
               	movq	%rdi, %rsi
               	addq	%r8, %rsi
               	movslq	%esi, %rsi
               	movslq	%edx, %r8
               	movq	%rsi, %rdx
               	addq	%r8, %rdx
               	movslq	%edx, %rdx
               	movslq	%ecx, %r8
               	movq	%rdx, %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r15, %r8
               	movq	%rcx, %r15
               	addq	%r8, %r15
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r15, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r9, %r15
               	movq	%r8, %r9
               	addq	%r15, %r9
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r9, %r15
               	movq	%r15, %r9
               	addq	%rax, %r9
               	movq	%r9, %rbx
               	addq	%r14, %rbx
               	leaq	0xfc3f(%rip), %r15      # 0x410150
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4006bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x724c0, %rbx          # imm = 0x724C0
               	jne	0x400540 <.text+0x280>
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x88(%rbp)
               	jmp	0x400551 <.text+0x291>
               	movl	$0x1, %ebx
               	movq	%rbx, -0x88(%rbp)
               	jmp	0x400551 <.text+0x291>
               	movq	-0x88(%rbp), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r14
               	movq	0x10(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
