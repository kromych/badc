
vtable_back_to_back.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400437 <.text+0x177>
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
               	callq	0x400667 <dlsym>
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
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	%edx, %r8
               	movslq	%ecx, %rdi
               	leaq	0xfd47(%rip), %r9       # 0x410150
               	movq	%r9, (%r11)
               	addq	$0x8, %r11
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	%edx, %rax
               	addq	$0x8, %r11
               	movslq	(%r11), %rdi
               	movl	%edi, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	0xfd10(%rip), %r9       # 0x410170
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	0xfcd6(%rip), %r8       # 0x410150
               	movq	(%r8), %rbx
               	leaq	-0x10(%rbp), %r12
               	leaq	0xfcd8(%rip), %r14      # 0x410160
               	movl	$0x2a, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x8, %r15d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rsi
               	movq	0x28(%rsp), %rdx
               	callq	*%r11
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %rbx
               	leaq	-0x10(%rbp), %r12
               	leaq	-0x40(%rbp), %r15
               	movl	$0x1, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	callq	*%r11
               	leaq	0xfc9e(%rip), %rbx      # 0x410180
               	movslq	-0x40(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40066d <printf>
               	movslq	%eax, %rax
               	movslq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
