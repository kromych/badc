
anonymous_aggregates.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	callq	0x400c67 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
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
               	subq	$0x60, %rsp
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003f9 <.text+0x179>
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
               	andq	%r8, %r11
               	cmpq	%r11, %rax
               	je	0x400437 <.text+0x1b7>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x12345678, %r8        # imm = 0x12345678
               	je	0x400467 <.text+0x1e7>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %r8d
               	movl	$0x90abcdef, %eax       # imm = 0x90ABCDEF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	%r11, %r8
               	je	0x400497 <.text+0x217>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	0x4004c3 <.text+0x243>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movl	$0xcafebabe, %eax       # imm = 0xCAFEBABE
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x4, %r11
               	movl	$0xbadf00d, %r8d        # imm = 0xBADF00D
               	movl	%r8d, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movl	(%rdi), %r8d
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	cmpq	%rdi, %r8
               	je	0x40050f <.text+0x28f>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0xbadf00d, %rax        # imm = 0xBADF00D
               	je	0x40053b <.text+0x2bb>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rax
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	je	0x400566 <.text+0x2e6>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x1, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movl	$0x2a, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x10, %r8
               	movl	$0x63, %edi
               	movl	%edi, (%r8)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x1, %rdi
               	je	0x4005c3 <.text+0x343>
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x2a, %rax
               	je	0x4005ef <.text+0x36f>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x63, %rdi
               	je	0x40061e <.text+0x39e>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movabsq	$0x40091eb851eb851f, %rax # imm = 0x40091EB851EB851F
               	movq	%rax, (%rdi)
               	leaq	-0x20(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x1, %rax
               	je	0x40065b <.text+0x3db>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x63, %r8
               	je	0x40068b <.text+0x40b>
               	movl	$0xe, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4006ad <.text+0x42d>
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0xa, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x30(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movl	$0x14, %edi
               	movl	%edi, (%r8)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movl	$0x1e, %eax
               	movl	%eax, (%rdi)
               	leaq	-0x30(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0xc, %rax
               	movl	$0x28, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %r8
               	cmpq	$0xa, %r8
               	je	0x40071e <.text+0x49e>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x14, %rdi
               	je	0x40074d <.text+0x4cd>
               	movl	$0x16, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x1e, %rax
               	je	0x400779 <.text+0x4f9>
               	movl	$0x17, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x28, %rdi
               	je	0x4007a8 <.text+0x528>
               	movl	$0x18, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movq	%r8, %rdi
               	addq	$0x4, %rdi
               	movl	$0x1234, %r8d           # imm = 0x1234
               	movw	%r8w, (%rdi)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x6, %r8
               	movl	$0x5678, %eax           # imm = 0x5678
               	movswq	%ax, %rax
               	movw	%ax, (%r8)
               	leaq	-0x40(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movl	$0x9, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %r8
               	movslq	(%r8), %rdi
               	cmpq	$0x7, %rdi
               	je	0x40081d <.text+0x59d>
               	movl	$0x1e, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movswq	(%rax), %r8
               	cmpq	$0x1234, %r8            # imm = 0x1234
               	je	0x40084e <.text+0x5ce>
               	movl	$0x1f, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x6, %r8
               	movswq	(%r8), %rax
               	movl	$0x5678, %r8d           # imm = 0x5678
               	movswq	%r8w, %r8
               	cmpq	%r8, %rax
               	je	0x400881 <.text+0x601>
               	movl	$0x20, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x9, %rdi
               	je	0x4008b0 <.text+0x630>
               	movl	$0x21, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	movq	%rax, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movl	$0x5678, %eax           # imm = 0x5678
               	movq	%rax, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movq	%r8, %rax
               	shlq	$0x10, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movq	%rdi, %rax
               	orq	%r8, %rax
               	leaq	-0x40(%rbp), %r8
               	movq	%r8, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	%r8, %rdi
               	je	0x400921 <.text+0x6a1>
               	movl	$0x22, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	$0x58, %r8d
               	movb	%r8b, (%rax)
               	leaq	-0x58(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movl	$0x61, %edi
               	movb	%dil, (%r8)
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x2, %rdi
               	movl	$0x62, %eax
               	movb	%al, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x3, %rax
               	movl	$0x63, %r8d
               	movb	%r8b, (%rax)
               	leaq	-0x58(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movl	$0x64, %edi
               	movb	%dil, (%r8)
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movabsq	$0x123456789abcdef0, %rax # imm = 0x123456789ABCDEF0
               	movq	%rax, (%rdi)
               	leaq	-0x58(%rbp), %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x58, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x4009d7 <.text+0x757>
               	movl	$0x28, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x61, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400a1b <.text+0x79b>
               	movl	$0x29, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x62, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400a5a <.text+0x7da>
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x63, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400a9e <.text+0x81e>
               	movl	$0x2b, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %rax
               	movq	%rax, %r8
               	xorq	$0x64, %r8
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	cmpq	$0x0, %rax
               	je	0x400add <.text+0x85d>
               	movl	$0x2c, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movabsq	$0x123456789abcdef0, %r11 # imm = 0x123456789ABCDEF0
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	0x400b16 <.text+0x896>
               	movl	$0x2d, %r8d
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400b5b <.text+0x8db>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400be2 <.text+0x962>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400bd9 <.text+0x959>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400bdd <.text+0x95d>
               	andb	%ch, 0x74(%rax)
               	je	0x400bed <.text+0x96d>
               	jae	0x400bb9 <.text+0x939>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400bf5 <.text+0x975>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400c6d <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400c1b <.text+0x99b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400ca2 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400c99 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400c9d <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x400cad <exit+0x40>
               	jae	0x400c79 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400cb5 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf473(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xf475(%rip)           # 0x4100e8
