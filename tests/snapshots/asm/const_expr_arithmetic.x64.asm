
const_expr_arithmetic.x64:	file format elf64-x86-64

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
               	callq	0x4008b7 <dlsym>
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x20, %r9d
               	movl	$0x4, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x8, %r8
               	je	0x4004a4 <.text+0x1e4>
               	leaq	0xff0c(%rip), %rbx      # 0x410370
               	movl	$0x20, %r11d
               	movl	$0x4, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x1, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4004a4 <.text+0x1e4>
               	movl	$0x18, %r9d
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %rbx
               	je	0x400516 <.text+0x256>
               	leaq	0xfead(%rip), %r14      # 0x410383
               	movl	$0x18, %r12d
               	movl	$0x4, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x2, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x400516 <.text+0x256>
               	movl	$0x40, %r9d
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x10, %r14
               	je	0x400586 <.text+0x2c6>
               	leaq	0xfe4f(%rip), %r15      # 0x410396
               	movl	$0x40, %ebx
               	movl	$0x4, %r9d
               	movq	%r9, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x3, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x400586 <.text+0x2c6>
               	movl	$0x40, %r9d
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r15
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x10, %r15
               	je	0x4005f2 <.text+0x332>
               	leaq	0xfdf1(%rip), %r12      # 0x4103a9
               	movl	$0x40, %r14d
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4005f2 <.text+0x332>
               	movl	$0x18, %r15d
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %rbx
               	je	0x400664 <.text+0x3a4>
               	leaq	0xfd98(%rip), %r12      # 0x4103bc
               	movl	$0x18, %r14d
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x5, %r15d
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x400664 <.text+0x3a4>
               	movl	$0x20, %r15d
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x8, %r12
               	je	0x4006d4 <.text+0x414>
               	leaq	0xfd3a(%rip), %r14      # 0x4103cf
               	movl	$0x20, %ebx
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x6, %r15d
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4006d4 <.text+0x414>
               	movl	$0x18, %r15d
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %r14
               	je	0x400746 <.text+0x486>
               	leaq	0xfce0(%rip), %rbx      # 0x4103e6
               	movl	$0x18, %r12d
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4008bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x7, %r15d
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x400746 <.text+0x486>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
