
switch_nested_case_in_compound.x64:	file format elf64-x86-64

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
               	callq	0x400857 <dlsym>
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
               	movl	$0x2, %r9d
               	movslq	%r9d, %r11
               	jmp	0x4004e4 <.text+0x224>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x7, %r9
               	je	0x400589 <.text+0x2c9>
               	jmp	0x400547 <.text+0x287>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x18(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movl	%edi, (%r9)
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x64, %r11
               	jne	0x40052e <.text+0x26e>
               	jmp	0x400510 <.text+0x250>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rdi
               	movq	%rdi, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r9
               	movq	%r9, %r11
               	addq	$0x2, %r11
               	movl	%r11d, (%rdi)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	movq	%r11, %rdi
               	addq	$0x4, %rdi
               	movl	%edi, (%r9)
               	jmp	0x400440 <.text+0x180>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r11
               	movq	%r11, %r9
               	orq	$0x4000, %r9            # imm = 0x4000
               	movl	%r9d, (%rdi)
               	jmp	0x400440 <.text+0x180>
               	cmpq	$0x1, %r11
               	je	0x400456 <.text+0x196>
               	cmpq	$0x2, %r11
               	je	0x40048a <.text+0x1ca>
               	cmpq	$0x3, %r11
               	je	0x4004cb <.text+0x20b>
               	jmp	0x400440 <.text+0x180>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rdi
               	movq	%rdi, %r9
               	orq	$0x1000, %r9            # imm = 0x1000
               	movl	%r9d, (%r11)
               	jmp	0x400529 <.text+0x269>
               	jmp	0x40048a <.text+0x1ca>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rdi
               	movq	%rdi, %r11
               	orq	$0x2000, %r11           # imm = 0x2000
               	movl	%r11d, (%r9)
               	jmp	0x400440 <.text+0x180>
               	leaq	0xfc02(%rip), %rbx      # 0x410150
               	movslq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40085d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x8(%rbp)
               	movl	$0x1, %eax
               	movslq	%eax, %r12
               	jmp	0x400641 <.text+0x381>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x106b, %rax           # imm = 0x106B
               	je	0x4006e8 <.text+0x428>
               	jmp	0x4006a6 <.text+0x3e6>
               	movl	$0x64, %ebx
               	movl	%ebx, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	movslq	-0x20(%rbp), %r12
               	movq	%rbx, %r8
               	addq	%r12, %r8
               	movl	%r8d, (%rax)
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x64, %r12
               	jne	0x40068d <.text+0x3cd>
               	jmp	0x40066d <.text+0x3ad>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rax
               	movq	%rax, %r12
               	addq	$0x2, %r12
               	movl	%r12d, (%r8)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r12
               	movq	%r12, %r8
               	addq	$0x4, %r8
               	movl	%r8d, (%rax)
               	jmp	0x40059d <.text+0x2dd>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r12
               	movq	%r12, %rax
               	orq	$0x4000, %rax           # imm = 0x4000
               	movl	%eax, (%r8)
               	jmp	0x40059d <.text+0x2dd>
               	cmpq	$0x1, %r12
               	je	0x4005b3 <.text+0x2f3>
               	cmpq	$0x2, %r12
               	je	0x4005e5 <.text+0x325>
               	cmpq	$0x3, %r12
               	je	0x400628 <.text+0x368>
               	jmp	0x40059d <.text+0x2dd>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rax
               	orq	$0x1000, %rax           # imm = 0x1000
               	movl	%eax, (%r12)
               	jmp	0x400688 <.text+0x3c8>
               	jmp	0x4005e5 <.text+0x325>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r8
               	movq	%r8, %r12
               	orq	$0x2000, %r12           # imm = 0x2000
               	movl	%r12d, (%rax)
               	jmp	0x40059d <.text+0x2dd>
               	leaq	0xfab8(%rip), %r14      # 0x410165
               	movslq	-0x8(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40085d <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
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
