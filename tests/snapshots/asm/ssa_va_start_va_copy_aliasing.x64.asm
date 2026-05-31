
ssa_va_start_va_copy_aliasing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4004ba <.text+0x1fa>
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
               	callq	0x400757 <dlsym>
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
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movq	(%r9), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r9)
               	movq	(%r11), %r9
               	leaq	-0x8(%rbp), %r11
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%r11, %r9
               	movq	%r8, %rax
               	addq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	(%r9), %r11
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %r8
               	leaq	0x10(%r8), %r10
               	movq	%r10, (%r9)
               	movq	(%r8), %r9
               	leaq	-0x8(%rbp), %r8
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x11, %r10d
               	imulq	%r10, %r11
               	movq	%r11, %rax
               	addq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x2, %ebx
               	movl	$0xb, %r12d
               	movl	$0x16, %r14d
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x4003f6 <.text+0x136>
               	addq	$0x30, %rsp
               	movq	%rax, %r15
               	addq	$0x55f0, %r12           # imm = 0x55F0
               	cmpq	%r12, %r15
               	je	0x400567 <.text+0x2a7>
               	leaq	0xfc20(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40075d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movl	$0x7, %ebx
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	callq	0x40044f <.text+0x18f>
               	addq	$0x20, %rsp
               	movq	%rax, %r12
               	movl	$0x77, %ebx
               	addq	$0x7, %rbx
               	cmpq	%rbx, %r12
               	je	0x4005ea <.text+0x32a>
               	leaq	0xfbbf(%rip), %r15      # 0x410172
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40075d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
