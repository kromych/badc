
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003fa <.text+0x13a>
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
               	callq	0x400e87 <dlsym>
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
               	leaq	0xfd17(%rip), %rdi      # 0x410150
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
               	addq	$0x4, %rdi
               	movl	%r8d, (%rdi)
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	cmpq	$0x2a, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x4004bb <.text+0x1fb>
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rdi
               	cmpq	$0x63, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	0x4004bb <.text+0x1fb>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x400525 <.text+0x265>
               	leaq	0xfc82(%rip), %r14      # 0x410158
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r15
               	leaq	-0x18(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	0xfc38(%rip), %rax      # 0x410168
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
               	addq	$0x4, %rax
               	movl	%r12d, (%rax)
               	leaq	-0x20(%rbp), %r15
               	movslq	(%r15), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4005b4 <.text+0x2f4>
               	leaq	-0x20(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xa8(%rbp)
               	jmp	0x4005b4 <.text+0x2f4>
               	movq	-0xa8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40061e <.text+0x35e>
               	leaq	0xfba1(%rip), %r14      # 0x410170
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %r15
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	-0x28(%rbp), %r12
               	leaq	0xfb57(%rip), %rax      # 0x410180
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	popq	%r11
               	movq	%r12, %r15
               	movl	$0xb, %r14d
               	movq	%r14, %rdi
               	callq	0x4003f6 <.text+0x136>
               	leaq	-0x28(%rbp), %r14
               	movl	%eax, (%r14)
               	movl	$0x16, %r15d
               	movq	%r15, %rdi
               	callq	0x4003f6 <.text+0x136>
               	leaq	-0x28(%rbp), %r15
               	addq	$0x4, %r15
               	movl	%eax, (%r15)
               	leaq	-0x28(%rbp), %r14
               	movslq	(%r14), %r15
               	cmpq	$0xb, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4006bb <.text+0x3fb>
               	leaq	-0x28(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %r15
               	cmpq	$0x16, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb0(%rbp)
               	jmp	0x4006bb <.text+0x3fb>
               	movq	-0xb0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400725 <.text+0x465>
               	leaq	0xfab2(%rip), %r12      # 0x410188
               	leaq	-0x28(%rbp), %r15
               	movslq	(%r15), %r14
               	leaq	-0x28(%rbp), %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	-0x38(%rbp), %rbx
               	leaq	0xfa68(%rip), %rax      # 0x410198
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
               	movq	%rbx, %r14
               	movq	0x20(%rsp), %r14
               	movslq	%r14d, %r14
               	leaq	-0x38(%rbp), %rax
               	movl	%r14d, (%rax)
               	movq	0x28(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%ebx, (%rax)
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4007d8 <.text+0x518>
               	leaq	-0x38(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	0x4007d8 <.text+0x518>
               	movq	-0xc0(%rbp), %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40081c <.text+0x55c>
               	leaq	-0x38(%rbp), %r14
               	addq	$0x8, %r14
               	movslq	(%r14), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40081c <.text+0x55c>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400897 <.text+0x5d7>
               	leaq	0xf96d(%rip), %r15      # 0x4101a4
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %r14
               	leaq	-0x38(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	leaq	-0x38(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	-0x48(%rbp), %r12
               	leaq	0xf915(%rip), %rax      # 0x4101b7
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
               	movq	%r12, %rbx
               	movq	0x28(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%ebx, (%rax)
               	movq	0x20(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x48(%rbp), %rax
               	movl	%r12d, (%rax)
               	leaq	-0x48(%rbp), %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40094f <.text+0x68f>
               	leaq	-0x48(%rbp), %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	0x40094f <.text+0x68f>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400993 <.text+0x6d3>
               	leaq	-0x48(%rbp), %rbx
               	addq	$0x8, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x400993 <.text+0x6d3>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400a0e <.text+0x74e>
               	leaq	0xf815(%rip), %r15      # 0x4101c3
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rbx
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	leaq	-0x48(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	-0x58(%rbp), %r14
               	leaq	0xf7bd(%rip), %rax      # 0x4101d6
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r14)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r14)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r14)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r14)
               	popq	%r11
               	movq	%r14, %r12
               	movq	0x20(%rsp), %r12
               	movslq	%r12d, %r12
               	leaq	-0x58(%rbp), %rax
               	movl	%r12d, (%rax)
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movl	%r14d, (%rax)
               	leaq	-0x58(%rbp), %r12
               	movslq	(%r12), %rax
               	cmpq	$0x2a, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400ac4 <.text+0x804>
               	leaq	-0x58(%rbp), %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	0x400ac4 <.text+0x804>
               	movq	-0xe0(%rbp), %rax
               	movq	%rax, -0xd8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b09 <.text+0x849>
               	leaq	-0x58(%rbp), %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x400b09 <.text+0x849>
               	movq	-0xd8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400b84 <.text+0x8c4>
               	leaq	0xf6be(%rip), %r15      # 0x4101e2
               	leaq	-0x58(%rbp), %rax
               	movslq	(%rax), %r12
               	leaq	-0x58(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r14
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	leaq	0xf666(%rip), %rax      # 0x4101f5
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
               	movq	%rbx, %r14
               	leaq	-0x78(%rbp), %r14
               	leaq	0xf636(%rip), %rax      # 0x410201
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r14)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r14)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r14)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r14)
               	popq	%r11
               	movq	%r14, %rbx
               	movq	0x28(%rsp), %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%ebx, (%rax)
               	leaq	-0x78(%rbp), %r14
               	movslq	(%r14), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400c64 <.text+0x9a4>
               	leaq	-0x78(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %rax
               	cmpq	$0x63, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xf0(%rbp)
               	jmp	0x400c64 <.text+0x9a4>
               	movq	-0xf0(%rbp), %rax
               	movq	%rax, -0xe8(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400ca8 <.text+0x9e8>
               	leaq	-0x78(%rbp), %r14
               	addq	$0x8, %r14
               	movslq	(%r14), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe8(%rbp)
               	jmp	0x400ca8 <.text+0x9e8>
               	movq	-0xe8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400d23 <.text+0xa63>
               	leaq	0xf54a(%rip), %r15      # 0x41020d
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %r14
               	leaq	-0x78(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rbx
               	leaq	-0x78(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400e8d <printf>
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
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
