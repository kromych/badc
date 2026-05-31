
anonymous_aggregates.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400bc7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
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
               	subq	$0x60, %rsp
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003df <.text+0x15f>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movabsq	$0x1234567890abcdef, %rax # imm = 0x1234567890ABCDEF
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %eax
               	movl	$0x90abcdef, %r8d       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	%r8, %rax
               	je	0x400421 <.text+0x1a1>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	0x40044a <.text+0x1ca>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	(%r8), %eax
               	movl	$0x90abcdef, %r8d       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	%r8, %rax
               	je	0x40047b <.text+0x1fb>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	0x4004a4 <.text+0x224>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	$0xcafebabe, %eax       # imm = 0xCAFEBABE
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0xbadf00d, %r8d        # imm = 0xBADF00D
               	movl	%r8d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movl	(%rdi), %r8d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	0x4004eb <.text+0x26b>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0xbadf00d, %rax        # imm = 0xBADF00D
               	je	0x400518 <.text+0x298>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r8
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %r8
               	je	0x400540 <.text+0x2c0>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movl	$0x1, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x8, %rdi
               	movl	$0x2a, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	addq	$0x10, %r8
               	movl	$0x63, %eax
               	movl	%eax, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x1, %rax
               	je	0x400596 <.text+0x316>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x2a, %rdi
               	je	0x4005bf <.text+0x33f>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x63, %rax
               	je	0x4005eb <.text+0x36b>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movabsq	$0x40091eb851eb851f, %rdi # imm = 0x40091EB851EB851F
               	movq	%rdi, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %rdi
               	cmpq	$0x1, %rdi
               	je	0x400625 <.text+0x3a5>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x10, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x63, %rax
               	je	0x400651 <.text+0x3d1>
               	movl	$0xe, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400672 <.text+0x3f2>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0xa, %edi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x14, %edi
               	movl	%edi, (%r8)
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x1e, %edi
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %r8
               	addq	$0xc, %r8
               	movl	$0x28, %edi
               	movl	%edi, (%r8)
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rdi
               	cmpq	$0xa, %rdi
               	je	0x4006d7 <.text+0x457>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x14, %rax
               	je	0x400703 <.text+0x483>
               	movl	$0x16, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x1e, %rdi
               	je	0x40072c <.text+0x4ac>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x28, %rax
               	je	0x400758 <.text+0x4d8>
               	movl	$0x18, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x1234, %edi           # imm = 0x1234
               	movw	%di, (%r8)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x6, %rax
               	movl	$0x5678, %edi           # imm = 0x5678
               	movswq	%di, %rdi
               	movw	%di, (%rax)
               	leaq	-0x40(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x9, %edi
               	movl	%edi, (%r8)
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x7, %rdi
               	je	0x4007c3 <.text+0x543>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x4, %rdi
               	movswq	(%rdi), %rax
               	cmpq	$0x1234, %rax           # imm = 0x1234
               	je	0x4007f0 <.text+0x570>
               	movl	$0x1f, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	addq	$0x6, %rax
               	movswq	(%rax), %rdi
               	movl	$0x5678, %eax           # imm = 0x5678
               	movswq	%ax, %rax
               	cmpq	%rax, %rdi
               	je	0x40081f <.text+0x59f>
               	movl	$0x20, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x9, %rax
               	je	0x40084b <.text+0x5cb>
               	movl	$0x21, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x5678, %edi           # imm = 0x5678
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	orq	%rdi, %rax
               	leaq	-0x40(%rbp), %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	%rax, %r8
               	je	0x4008aa <.text+0x62a>
               	movl	$0x22, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	movl	$0x58, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x1, %rdi
               	movl	$0x61, %eax
               	movb	%al, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x2, %r8
               	movl	$0x62, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x3, %rdi
               	movl	$0x63, %eax
               	movb	%al, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x64, %eax
               	movb	%al, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	addq	$0x8, %rdi
               	movabsq	$0x123456789abcdef0, %rax # imm = 0x123456789ABCDEF0
               	movq	%rax, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	movzbq	(%r8), %rax
               	xorq	$0x58, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400951 <.text+0x6d1>
               	movl	$0x28, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	xorq	$0x61, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40098b <.text+0x70b>
               	movl	$0x29, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x62, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4009c9 <.text+0x749>
               	movl	$0x2a, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	xorq	$0x63, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400a03 <.text+0x783>
               	movl	$0x2b, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400a41 <.text+0x7c1>
               	movl	$0x2c, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	cmpq	%r11, %r8
               	je	0x400a70 <.text+0x7f0>
               	movl	$0x2d, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
