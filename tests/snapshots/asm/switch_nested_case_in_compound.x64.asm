
switch_nested_case_in_compound.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
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
               	callq	0x400807 <dlsym>
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x2, %r9d
               	movslq	%r9d, %r9
               	jmp	0x4004be <.text+0x1fe>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x7, %r11
               	je	0x40055d <.text+0x29d>
               	jmp	0x40051b <.text+0x25b>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x18(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	addq	%r11, %r8
               	movl	%r8d, (%r9)
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x64, %r11
               	jne	0x400505 <.text+0x245>
               	jmp	0x4004ea <.text+0x22a>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x2, %r8
               	movl	%r8d, (%r11)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x4, %r8
               	movl	%r8d, (%r9)
               	jmp	0x400429 <.text+0x169>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x4000, %r11           # imm = 0x4000
               	movl	%r11d, (%r8)
               	jmp	0x400429 <.text+0x169>
               	cmpq	$0x1, %r9
               	je	0x40043f <.text+0x17f>
               	cmpq	$0x2, %r9
               	je	0x400470 <.text+0x1b0>
               	cmpq	$0x3, %r9
               	je	0x4004a8 <.text+0x1e8>
               	jmp	0x400429 <.text+0x169>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r11
               	orq	$0x1000, %r11           # imm = 0x1000
               	movl	%r11d, (%r8)
               	jmp	0x400500 <.text+0x240>
               	jmp	0x400470 <.text+0x1b0>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	orq	$0x2000, %r9            # imm = 0x2000
               	movl	%r9d, (%r11)
               	jmp	0x400429 <.text+0x169>
               	leaq	0xfc2e(%rip), %rbx      # 0x410150
               	movslq	-0x8(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40080d <printf>
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
               	movslq	%eax, %rax
               	jmp	0x400603 <.text+0x343>
               	movslq	-0x8(%rbp), %r12
               	cmpq	$0x106b, %r12           # imm = 0x106B
               	je	0x4006a4 <.text+0x3e4>
               	jmp	0x400662 <.text+0x3a2>
               	movl	$0x64, %ebx
               	movl	%ebx, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	movslq	-0x20(%rbp), %r12
               	addq	%r12, %rbx
               	movl	%ebx, (%rax)
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x64, %r12
               	jne	0x40064a <.text+0x38a>
               	jmp	0x40062f <.text+0x36f>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %rbx
               	addq	$0x2, %rbx
               	movl	%ebx, (%r12)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rbx
               	addq	$0x4, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x400571 <.text+0x2b1>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	orq	$0x4000, %r12           # imm = 0x4000
               	movl	%r12d, (%rbx)
               	jmp	0x400571 <.text+0x2b1>
               	cmpq	$0x1, %rax
               	je	0x400587 <.text+0x2c7>
               	cmpq	$0x2, %rax
               	je	0x4005b5 <.text+0x2f5>
               	cmpq	$0x3, %rax
               	je	0x4005ed <.text+0x32d>
               	jmp	0x400571 <.text+0x2b1>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	orq	$0x1000, %r12           # imm = 0x1000
               	movl	%r12d, (%rbx)
               	jmp	0x400645 <.text+0x385>
               	jmp	0x4005b5 <.text+0x2f5>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %rax
               	orq	$0x2000, %rax           # imm = 0x2000
               	movl	%eax, (%r12)
               	jmp	0x400571 <.text+0x2b1>
               	leaq	0xfafc(%rip), %r14      # 0x410165
               	movslq	-0x8(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40080d <printf>
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
