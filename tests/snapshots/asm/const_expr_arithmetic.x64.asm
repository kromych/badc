
const_expr_arithmetic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
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
               	callq	0x400867 <dlsym>
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
               	je	0x40049c <.text+0x1dc>
               	leaq	0xff0f(%rip), %rbx      # 0x410370
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
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40049c <.text+0x1dc>
               	movl	$0x18, %eax
               	movl	$0x4, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %rbx
               	je	0x400504 <.text+0x244>
               	leaq	0xfeb9(%rip), %r14      # 0x410383
               	movl	$0x18, %r12d
               	movl	$0x4, %eax
               	movq	%rax, %r11
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
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400504 <.text+0x244>
               	movl	$0x40, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x10, %r14
               	je	0x40056a <.text+0x2aa>
               	leaq	0xfe65(%rip), %r15      # 0x410396
               	movl	$0x40, %ebx
               	movl	$0x4, %eax
               	movq	%rax, %r11
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
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40056a <.text+0x2aa>
               	movl	$0x40, %eax
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r15
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x10, %r15
               	je	0x4005cf <.text+0x30f>
               	leaq	0xfe11(%rip), %r12      # 0x4103a9
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
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	%r15d, -0x8(%rbp)
               	jmp	0x4005cf <.text+0x30f>
               	movl	$0x18, %r15d
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %rbx
               	je	0x400637 <.text+0x377>
               	leaq	0xfdbc(%rip), %r14      # 0x4103bc
               	movl	$0x18, %eax
               	movl	$0x4, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400637 <.text+0x377>
               	movl	$0x20, %eax
               	movl	$0x4, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x8, %r14
               	je	0x40069d <.text+0x3dd>
               	leaq	0xfd6b(%rip), %r12      # 0x4103cf
               	movl	$0x20, %ebx
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x6, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x40069d <.text+0x3dd>
               	movl	$0x18, %eax
               	movl	$0x4, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x6, %r12
               	je	0x400705 <.text+0x445>
               	leaq	0xfd1b(%rip), %r15      # 0x4103e6
               	movl	$0x18, %r14d
               	movl	$0x4, %eax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40086d <printf>
               	movslq	%eax, %rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400705 <.text+0x445>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
