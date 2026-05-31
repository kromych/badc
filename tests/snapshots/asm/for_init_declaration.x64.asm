
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4006e9 <.text+0x429>
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
               	callq	0x400a27 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400428 <.text+0x168>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	0x400470 <.text+0x1b0>
               	jmp	0x400457 <.text+0x197>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400428 <.text+0x168>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r9, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r8)
               	jmp	0x40043e <.text+0x17e>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0xa, %r9d
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x40049e <.text+0x1de>
               	movslq	-0x10(%rbp), %r9
               	movslq	-0x18(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x400507 <.text+0x247>
               	jmp	0x4004e1 <.text+0x221>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$-0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x40049e <.text+0x1de>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movslq	-0x10(%rbp), %r8
               	movslq	-0x18(%rbp), %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %rdi
               	addq	%rsi, %rdi
               	movl	%edi, (%r11)
               	jmp	0x4004b4 <.text+0x1f4>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x400531 <.text+0x271>
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400565 <.text+0x2a5>
               	jmp	0x400560 <.text+0x2a0>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400531 <.text+0x271>
               	jmp	0x400547 <.text+0x287>
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x40058c <.text+0x2cc>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x4005d4 <.text+0x314>
               	jmp	0x4005bb <.text+0x2fb>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40058c <.text+0x2cc>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r9, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4005a2 <.text+0x2e2>
               	movl	$0xa, %edi
               	movl	%edi, -0x18(%rbp)
               	jmp	0x4005e1 <.text+0x321>
               	movslq	-0x18(%rbp), %rdi
               	cmpq	$0xd, %rdi
               	jge	0x400629 <.text+0x369>
               	jmp	0x400610 <.text+0x350>
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x4005e1 <.text+0x321>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	movslq	-0x18(%rbp), %rdi
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movl	%r9d, (%r8)
               	jmp	0x4005f7 <.text+0x337>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfb08(%rip), %r11      # 0x410150
               	xorq	%r9, %r9
               	movl	$0x1, %r8d
               	movl	%r8d, (%r11)
               	movl	$0x4, %edi
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movl	$0x2, %esi
               	movl	%esi, (%r8)
               	movq	%r11, %rdx
               	addq	$0x8, %rdx
               	movl	%edi, (%rdx)
               	movl	%r9d, -0x8(%rbp)
               	movq	%r11, -0x10(%rbp)
               	jmp	0x400684 <.text+0x3c4>
               	movq	-0x10(%rbp), %r11
               	leaq	0xfac1(%rip), %rsi      # 0x410150
               	movq	%rsi, %r9
               	addq	$0xc, %r9
               	cmpq	%r9, %r11
               	jge	0x4006dc <.text+0x41c>
               	jmp	0x4006c0 <.text+0x400>
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %rsi
               	movq	%rsi, %r11
               	addq	$0x4, %r11
               	movq	%r11, (%r9)
               	jmp	0x400684 <.text+0x3c4>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rsi
               	movq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdx
               	movq	%rsi, %r9
               	addq	%rdx, %r9
               	movl	%r9d, (%r11)
               	jmp	0x4006a7 <.text+0x3e7>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	callq	0x40040d <.text+0x14d>
               	cmpq	$0x2d, %rax
               	je	0x400760 <.text+0x4a0>
               	leaq	0xfa40(%rip), %rbx      # 0x410160
               	callq	0x40040d <.text+0x14d>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a2d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x40047d <.text+0x1bd>
               	cmpq	$0x32, %rax
               	je	0x4007b8 <.text+0x4f8>
               	leaq	0xf9fc(%rip), %r12      # 0x410175
               	callq	0x40047d <.text+0x1bd>
               	movq	%rax, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400a2d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400514 <.text+0x254>
               	cmpq	$0x2a, %rax
               	je	0x400811 <.text+0x551>
               	leaq	0xf9b9(%rip), %r15      # 0x41018a
               	callq	0x400514 <.text+0x254>
               	movq	%rax, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400a2d <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400571 <.text+0x2b1>
               	cmpq	$0x2b, %rax
               	je	0x40086a <.text+0x5aa>
               	leaq	0xf974(%rip), %r14      # 0x41019e
               	callq	0x400571 <.text+0x2b1>
               	movq	%rax, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400a2d <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400636 <.text+0x376>
               	cmpq	$0x7, %rax
               	je	0x4008c2 <.text+0x602>
               	leaq	0xf933(%rip), %rbx      # 0x4101b6
               	callq	0x400636 <.text+0x376>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400a2d <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
