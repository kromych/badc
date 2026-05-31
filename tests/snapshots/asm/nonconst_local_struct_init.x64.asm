
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400411 <.text+0x151>
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
               	callq	0x400f07 <dlsym>
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
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x2a, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x63, %r10d
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x18(%rbp), %r8
               	leaq	0xfd00(%rip), %rdi      # 0x410150
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	0x20(%rsp), %rsi
               	movslq	%esi, %rsi
               	leaq	-0x18(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	0x28(%rsp), %r8
               	movslq	%r8d, %r8
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movl	%r8d, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x2a, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x4004d8 <.text+0x218>
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rsi
               	cmpq	$0x63, %rsi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	0x4004d8 <.text+0x218>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x400545 <.text+0x285>
               	leaq	0xfc65(%rip), %r14      # 0x410158
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r15
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	leaq	0xfc18(%rip), %rax      # 0x410168
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movl	$0x7, %r15d
               	leaq	-0x20(%rbp), %rax
               	movl	%r15d, (%rax)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x4, %r15
               	movl	%r12d, (%r15)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %r15
               	cmpq	$0x7, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005da <.text+0x31a>
               	leaq	-0x20(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r15
               	cmpq	$0x63, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	jmp	0x4005da <.text+0x31a>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400648 <.text+0x388>
               	leaq	0xfb7b(%rip), %r14      # 0x410170
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rbx
               	leaq	0xfb2d(%rip), %rax      # 0x410180
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	popq	%r11
               	movq	%rbx, %r15
               	movl	$0xb, %r12d
               	movq	%r12, %rdi
               	callq	0x40040d <.text+0x14d>
               	leaq	-0x28(%rbp), %r12
               	movl	%eax, (%r12)
               	movl	$0x16, %r15d
               	movq	%r15, %rdi
               	callq	0x40040d <.text+0x14d>
               	leaq	-0x28(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x4, %r12
               	movl	%eax, (%r12)
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %r12
               	cmpq	$0xb, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4006ec <.text+0x42c>
               	leaq	-0x28(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r12
               	cmpq	$0x16, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	jmp	0x4006ec <.text+0x42c>
               	movq	-0xb0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400759 <.text+0x499>
               	leaq	0xfa81(%rip), %rbx      # 0x410188
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %r12
               	leaq	-0x28(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r15
               	leaq	0xfa34(%rip), %rax      # 0x410198
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r15)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r15)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r15)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r15)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r15)
               	popq	%r11
               	movq	%r15, %r12
               	movq	0x20(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x38(%rbp), %rax
               	movl	%r12d, (%rax)
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movl	%r15d, (%r12)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %r12
               	cmpq	$0x2a, %r12
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400814 <.text+0x554>
               	leaq	-0x38(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	cmpq	$0x0, %r12
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	0x400814 <.text+0x554>
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40085b <.text+0x59b>
               	leaq	-0x38(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r12
               	cmpq	$0x63, %r12
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40085b <.text+0x59b>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4008dc <.text+0x61c>
               	leaq	0xf92e(%rip), %r14      # 0x4101a4
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %r12
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r15
               	leaq	-0x38(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rbx
               	leaq	0xf8d0(%rip), %rax      # 0x4101b7
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rbx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rbx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rbx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rbx)
               	popq	%r11
               	movq	%rbx, %r15
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x48(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movl	%r15d, (%rbx)
               	movq	0x20(%rsp), %rax
               	movslq	%eax, %rax
               	leaq	-0x48(%rbp), %rbx
               	movl	%eax, (%rbx)
               	leaq	-0x48(%rbp), %r15
               	movslq	(%r15), %rbx
               	cmpq	$0x2a, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xd0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x400995 <.text+0x6d5>
               	leaq	-0x48(%rbp), %rbx
               	movq	%rbx, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rbx
               	cmpq	$0x0, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xd0(%rbp)
               	jmp	0x400995 <.text+0x6d5>
               	movq	-0xd0(%rbp), %r15
               	movq	%r15, -0xc8(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4009dc <.text+0x71c>
               	leaq	-0x48(%rbp), %rbx
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movslq	(%r15), %rbx
               	cmpq	$0x63, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xc8(%rbp)
               	jmp	0x4009dc <.text+0x71c>
               	movq	-0xc8(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400a5e <.text+0x79e>
               	leaq	0xf7cc(%rip), %r14      # 0x4101c3
               	leaq	-0x48(%rbp), %r15
               	movslq	(%r15), %rbx
               	leaq	-0x48(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r15
               	leaq	-0x48(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r12
               	leaq	0xf76d(%rip), %rax      # 0x4101d6
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r12)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r12)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r12)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movq	0x20(%rsp), %r15
               	movslq	%r15d, %r15
               	leaq	-0x58(%rbp), %rax
               	movl	%r15d, (%rax)
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movl	%r12d, (%r15)
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %r15
               	cmpq	$0x2a, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b1d <.text+0x85d>
               	leaq	-0x58(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r15
               	cmpq	$0x0, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	0x400b1d <.text+0x85d>
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b64 <.text+0x8a4>
               	leaq	-0x58(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r15
               	cmpq	$0x63, %r15
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400b64 <.text+0x8a4>
               	movq	-0xd8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400be5 <.text+0x925>
               	leaq	0xf663(%rip), %r14      # 0x4101e2
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r12
               	leaq	-0x58(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rbx
               	leaq	0xf605(%rip), %rax      # 0x4101f5
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rbx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rbx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rbx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rbx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rbx)
               	popq	%r11
               	movq	%rbx, %r12
               	leaq	-0x78(%rbp), %rax
               	leaq	0xf5d5(%rip), %r12      # 0x410201
               	pushq	%r11
               	movq	(%r12), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%r12), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%r12), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%r12), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%r12), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	movq	%rax, %rbx
               	movq	0x28(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x78(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movl	%ebx, (%rax)
               	leaq	-0x78(%rbp), %r12
               	movslq	(%r12), %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400cd2 <.text+0xa12>
               	leaq	-0x78(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x63, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	jmp	0x400cd2 <.text+0xa12>
               	movq	-0xf0(%rbp), %r12
               	movq	%r12, -0xe8(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x400d1a <.text+0xa5a>
               	leaq	-0x78(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	jmp	0x400d1a <.text+0xa5a>
               	movq	-0xe8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400d9c <.text+0xadc>
               	leaq	0xf4d8(%rip), %r14      # 0x41020d
               	leaq	-0x78(%rbp), %r12
               	movslq	(%r12), %r15
               	leaq	-0x78(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r12
               	leaq	-0x78(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400f0d <printf>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
