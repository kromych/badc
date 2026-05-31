
for_init_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4006aa <.text+0x3ea>
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
               	callq	0x4009c7 <dlsym>
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
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400411 <.text+0x151>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	0x400453 <.text+0x193>
               	jmp	0x40043d <.text+0x17d>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x400411 <.text+0x151>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movslq	-0x10(%rbp), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400427 <.text+0x167>
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
               	jmp	0x400481 <.text+0x1c1>
               	movslq	-0x10(%rbp), %r9
               	movslq	-0x18(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x4004de <.text+0x21e>
               	jmp	0x4004be <.text+0x1fe>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$-0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	0x400481 <.text+0x1c1>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	movslq	-0x10(%rbp), %r8
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movl	%r11d, (%r9)
               	jmp	0x400497 <.text+0x1d7>
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
               	jmp	0x400508 <.text+0x248>
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400539 <.text+0x279>
               	jmp	0x400534 <.text+0x274>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	0x400508 <.text+0x248>
               	jmp	0x40051e <.text+0x25e>
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
               	jmp	0x400560 <.text+0x2a0>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x4005a2 <.text+0x2e2>
               	jmp	0x40058c <.text+0x2cc>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x400560 <.text+0x2a0>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movslq	-0x10(%rbp), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400576 <.text+0x2b6>
               	movl	$0xa, %r8d
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x4005b1 <.text+0x2f1>
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0xd, %r8
               	jge	0x4005f3 <.text+0x333>
               	jmp	0x4005dd <.text+0x31d>
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x4005b1 <.text+0x2f1>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	movslq	-0x18(%rbp), %r9
               	addq	%r9, %r11
               	movl	%r11d, (%r8)
               	jmp	0x4005c7 <.text+0x307>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	0xfb3e(%rip), %r11      # 0x410150
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
               	jmp	0x40064e <.text+0x38e>
               	movq	-0x10(%rbp), %r11
               	leaq	0xfaf7(%rip), %rsi      # 0x410150
               	addq	$0xc, %rsi
               	cmpq	%rsi, %r11
               	jge	0x40069d <.text+0x3dd>
               	jmp	0x400684 <.text+0x3c4>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %r11
               	addq	$0x4, %r11
               	movq	%r11, (%rsi)
               	jmp	0x40064e <.text+0x38e>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	addq	%rdx, %r9
               	movl	%r9d, (%r11)
               	jmp	0x40066e <.text+0x3ae>
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
               	callq	0x4003f6 <.text+0x136>
               	cmpq	$0x2d, %rax
               	je	0x400717 <.text+0x457>
               	leaq	0xfa84(%rip), %rbx      # 0x410160
               	callq	0x4003f6 <.text+0x136>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4009cd <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400460 <.text+0x1a0>
               	cmpq	$0x32, %rax
               	je	0x40076a <.text+0x4aa>
               	leaq	0xfa45(%rip), %r12      # 0x410175
               	callq	0x400460 <.text+0x1a0>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4009cd <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4004eb <.text+0x22b>
               	cmpq	$0x2a, %rax
               	je	0x4007be <.text+0x4fe>
               	leaq	0xfa07(%rip), %r14      # 0x41018a
               	callq	0x4004eb <.text+0x22b>
               	movq	%rax, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4009cd <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400545 <.text+0x285>
               	cmpq	$0x2b, %rax
               	je	0x400812 <.text+0x552>
               	leaq	0xf9c7(%rip), %rbx      # 0x41019e
               	callq	0x400545 <.text+0x285>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4009cd <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400600 <.text+0x340>
               	cmpq	$0x7, %rax
               	je	0x400865 <.text+0x5a5>
               	leaq	0xf98b(%rip), %r12      # 0x4101b6
               	callq	0x400600 <.text+0x340>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4009cd <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
