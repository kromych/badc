
signed_cast_extends.x64:	file format elf64-x86-64

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
               	callq	0x4008c7 <dlsym>
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xff, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	0x40043f <.text+0x17f>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x80, %r11
               	je	0x400479 <.text+0x1b9>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %r11d
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7f, %r11
               	je	0x4004b3 <.text+0x1f3>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %r11d
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	0x4004ef <.text+0x22f>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x78, %r11
               	je	0x40052b <.text+0x26b>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234abff, %r11d      # imm = 0x1234ABFF
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	0x400567 <.text+0x2a7>
               	movl	$0x6, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffff, %r11d          # imm = 0xFFFF
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	0x4005a1 <.text+0x2e1>
               	movl	$0x7, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %r11d          # imm = 0x8000
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x8000, %r11          # imm = 0x8000
               	je	0x4005db <.text+0x31b>
               	movl	$0x8, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x12345678, %r11d      # imm = 0x12345678
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x5678, %r11           # imm = 0x5678
               	je	0x400617 <.text+0x357>
               	movl	$0x9, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234ffff, %r11d      # imm = 0x1234FFFF
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movswq	%r11w, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x1, %r11
               	je	0x400653 <.text+0x393>
               	movl	$0xa, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2a, %r11
               	movsbq	%r11b, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x2a, %r11
               	je	0x40068a <.text+0x3ca>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r11
               	movl	$0xff, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	addq	$0x1, %r8
               	movl	$0x42, %r9d
               	movb	%r9b, (%r8)
               	leaq	-0xb8(%rbp), %r11
               	addq	$0x2, %r11
               	movl	$0x10, %r9d
               	movb	%r9b, (%r11)
               	leaq	-0xb8(%rbp), %r8
               	movzbq	(%r8), %r9
               	movsbq	%r9b, %r9
               	movslq	%r9d, %r9
               	cmpq	$-0x1, %r9
               	je	0x400700 <.text+0x440>
               	movl	$0xc, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %r9
               	movzbq	(%r9), %r8
               	movsbq	%r8b, %r8
               	shlq	$0x8, %r8
               	movslq	%r8d, %r8
               	leaq	-0xb8(%rbp), %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r11
               	orq	%r11, %r8
               	movslq	%r8d, %r8
               	cmpq	$-0xbe, %r8
               	je	0x400754 <.text+0x494>
               	movl	$0xd, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf9f5(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x4008cd <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
