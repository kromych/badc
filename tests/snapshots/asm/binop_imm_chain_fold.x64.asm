
binop_imm_chain_fold.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r11
               	addq	$0x3, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %r8
               	addq	$0x7, %r8
               	movslq	%r8d, %r8
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %rdi
               	subq	$0x3, %rdi
               	movslq	%edi, %rdi
               	movq	%r9, %r11
               	subq	$0x4, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %rsi
               	addq	$0x9, %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %r11
               	subq	$0x2, %r11
               	movslq	%r11d, %r11
               	movq	%r11, %rdx
               	subq	$0x5, %rdx
               	movslq	%edx, %rdx
               	movq	%r9, %r11
               	andq	$0x3f, %r11
               	movq	%r9, %rcx
               	orq	$0x3, %rcx
               	movq	%r9, %rax
               	xorq	$0x3, %rax
               	movslq	%r8d, %r9
               	movslq	%edi, %r8
               	movq	%r9, %rdi
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
               	movslq	%r11d, %r8
               	movq	%rdx, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movslq	%ecx, %r8
               	movq	%r11, %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %r8
               	movq	%rcx, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rbx
               	leaq	0xfc46(%rip), %r12      # 0x410150
               	movslq	%ebx, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4006bd <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movslq	%ebx, %r11
               	cmpq	$0x53, %r11
               	jne	0x40053c <.text+0x27c>
               	xorq	%r11, %r11
               	movq	%r11, -0x60(%rbp)
               	jmp	0x40054b <.text+0x28b>
               	movl	$0x1, %r11d
               	movq	%r11, -0x60(%rbp)
               	jmp	0x40054b <.text+0x28b>
               	movq	-0x60(%rbp), %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
