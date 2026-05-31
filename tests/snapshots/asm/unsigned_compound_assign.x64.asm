
unsigned_compound_assign.x64:	file format elf64-x86-64

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
               	callq	0x4008a7 <dlsym>
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x64, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movl	(%r9), %r11d
               	addq	$0x5, %r11
               	movl	%r11d, (%r9)
               	movl	-0x8(%rbp), %r8d
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400492 <.text+0x1d2>
               	leaq	0xfcf9(%rip), %rbx      # 0x410150
               	movl	-0x8(%rbp), %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r12
               	movl	(%r12), %eax
               	subq	$0x3, %rax
               	movl	%eax, (%r12)
               	movl	-0x8(%rbp), %ebx
               	xorq	$0x66, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400507 <.text+0x247>
               	leaq	0xfc9a(%rip), %r14      # 0x410166
               	movl	-0x8(%rbp), %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e8, %r15d           # imm = 0x3E8
               	movq	%r15, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$0x19f, %r15            # imm = 0x19F
               	movq	%r15, (%rax)
               	movq	-0x10(%rbp), %r14
               	cmpq	$0x587, %r14            # imm = 0x587
               	je	0x400575 <.text+0x2b5>
               	leaq	0xfc42(%rip), %r12      # 0x41017c
               	movq	-0x10(%rbp), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41c, %r15d           # imm = 0x41C
               	movl	%r15d, -0x18(%rbp)
               	movl	$0x19f, %eax            # imm = 0x19F
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %r15
               	movl	(%r15), %r12d
               	movslq	%eax, %rax
               	addq	%rax, %r12
               	movl	%r12d, (%r15)
               	movl	-0x18(%rbp), %eax
               	xorq	$0x5bb, %rax            # imm = 0x5BB
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4005f9 <.text+0x339>
               	leaq	0xfbd7(%rip), %r14      # 0x410195
               	movl	-0x18(%rbp), %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc8, %r12d
               	movb	%r12b, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movzbq	(%rax), %r12
               	addq	$0x3c, %r12
               	movb	%r12b, (%rax)
               	movzbq	-0x28(%rbp), %r14
               	xorq	$0x4, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	je	0x40067a <.text+0x3ba>
               	leaq	0xfb78(%rip), %r15      # 0x4101b6
               	movzbq	-0x28(%rbp), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r12
               	xorq	%rax, %rax
               	movl	%eax, (%r12)
               	leaq	-0x40(%rbp), %r15
               	addq	$0x4, %r15
               	movl	$0xa, %eax
               	movl	%eax, (%r15)
               	leaq	-0x40(%rbp), %r12
               	addq	$0x8, %r12
               	movl	$0x14, %eax
               	movl	%eax, (%r12)
               	leaq	-0x40(%rbp), %r15
               	addq	$0xc, %r15
               	movl	$0x1e, %eax
               	movl	%eax, (%r15)
               	leaq	-0x40(%rbp), %r12
               	addq	$0x10, %r12
               	movl	$0x28, %eax
               	movl	%eax, (%r12)
               	leaq	-0x40(%rbp), %r15
               	movq	%r15, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$0xc, %r15
               	movq	%r15, (%rax)
               	movq	-0x48(%rbp), %r12
               	movslq	(%r12), %r15
               	cmpq	$0x1e, %r15
               	je	0x400746 <.text+0x486>
               	leaq	0xfaca(%rip), %r14      # 0x4101d2
               	movq	-0x48(%rbp), %r15
               	movslq	(%r15), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4008ad <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
