
local_array_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400708 <.text+0x488>
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
               	callq	0x400bb7 <dlsym>
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
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0x1015f(%rip), %r8      # 0x410548
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	movq	%r9, %rdi
               	leaq	0xfd31(%rip), %rdi      # 0x410148
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movzwq	(%r9), %r8
               	leaq	-0x8(%rbp), %r9
               	movw	%r8w, (%r9)
               	leaq	0xff11(%rip), %rdi      # 0x410348
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movzwq	(%r11), %r9
               	leaq	-0x8(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rdi
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%rdi, %r11
               	movslq	%r11d, %r11
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r9
               	addq	$0x2, %r9
               	movzwq	(%r9), %rdi
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0x1009d(%rip), %rdi     # 0x41054c
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%rdi), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%rdi), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%rdi), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%rdi), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movl	%r8d, (%rsi)
               	movq	%r11, %rdi
               	imulq	%r9, %rdi
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movl	%edi, (%r11)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0xffd6(%rip), %rdi      # 0x410558
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%r11, %r8
               	subq	%r9, %r8
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movq	%r8, (%r11)
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %r11
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0xff6c(%rip), %r8       # 0x410568
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	movq	%r9, %rdi
               	movq	%r11, %rdi
               	addq	$0x61, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	leaq	-0x8(%rbp), %rdi
               	movb	%r8b, (%rdi)
               	movl	$0x62, %r9d
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movb	%r9b, (%r8)
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r11
               	andq	$0xff, %r11
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x2, %r8
               	movb	%r11b, (%r8)
               	movl	$0x64, %edi
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x3, %r11
               	movb	%dil, (%r11)
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x4006a6 <.text+0x426>
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x4006fb <.text+0x47b>
               	jmp	0x4006d5 <.text+0x455>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r11
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4006a6 <.text+0x426>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r11
               	leaq	-0x8(%rbp), %r8
               	movslq	-0x18(%rbp), %r9
               	movq	%r8, %rsi
               	addq	%r9, %rsi
               	movzbq	(%rsi), %r9
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	movl	%esi, (%rdi)
               	jmp	0x4006bc <.text+0x43c>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfa1b(%rip), %r11      # 0x410148
               	movq	%r11, %r9
               	addq	$0xa, %r9
               	movl	$0x1234, %r11d          # imm = 0x1234
               	movw	%r11w, (%r9)
               	leaq	0xfc00(%rip), %r8       # 0x410348
               	movq	%r8, %r11
               	addq	$0xa, %r11
               	movl	$0x5678, %r8d           # imm = 0x5678
               	movw	%r8w, (%r11)
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r8
               	movl	$0x471b20, %ebx         # imm = 0x471B20
               	movslq	%ebx, %rbx
               	movq	%rbx, %r11
               	addq	$0x5678, %r11           # imm = 0x5678
               	movslq	%r11d, %r11
               	cmpq	%r11, %r8
               	je	0x4007b2 <.text+0x532>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	movl	$0x4, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x400493 <.text+0x213>
               	movq	%rax, %r8
               	cmpq	$0x12, %r8
               	je	0x400800 <.text+0x580>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r14d
               	movl	$0x4, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400566 <.text+0x2e6>
               	movq	%rax, %r12
               	cmpq	$0x14, %r12
               	je	0x40084e <.text+0x5ce>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x4005e3 <.text+0x363>
               	movq	%rax, %r12
               	cmpq	$0x12c, %r12            # imm = 0x12C
               	je	0x400894 <.text+0x614>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r15
               	leaq	0xfccd(%rip), %r12      # 0x41056c
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%r15)
               	movzbq	0x8(%r12), %rax
               	movb	%al, 0x8(%r15)
               	movzbq	0x9(%r12), %rax
               	movb	%al, 0x9(%r15)
               	movzbq	0xa(%r12), %rax
               	movb	%al, 0xa(%r15)
               	movzbq	0xb(%r12), %rax
               	movb	%al, 0xb(%r15)
               	popq	%rax
               	movq	%r15, %r14
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %r12
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x4, %r15
               	movslq	(%r15), %r14
               	movq	%r12, %r15
               	addq	%r14, %r15
               	movslq	%r15d, %r15
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %r14
               	movq	%r15, %r12
               	addq	%r14, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x6, %r12
               	je	0x400944 <.text+0x6c4>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r14
               	leaq	0xfc2f(%rip), %r12      # 0x41057e
               	pushq	%rax
               	movq	(%r12), %rax
               	movq	%rax, (%r14)
               	popq	%rax
               	movq	%r14, %r15
               	leaq	-0x18(%rbp), %r15
               	movzbq	(%r15), %r12
               	movq	%r12, %r15
               	xorq	$0x68, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x28(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4009d3 <.text+0x753>
               	leaq	-0x18(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x4, %r15
               	movzbq	(%r15), %r12
               	movq	%r12, %r15
               	xorq	$0x6f, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x28(%rbp)
               	jmp	0x4009d3 <.text+0x753>
               	movq	-0x28(%rbp), %r15
               	movq	%r15, -0x20(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x400a1b <.text+0x79b>
               	leaq	-0x18(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x5, %r15
               	movzbq	(%r15), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x20(%rbp)
               	jmp	0x400a1b <.text+0x79b>
               	movq	-0x20(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400a54 <.text+0x7d4>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400ab3 <.text+0x833>
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
               	jae	0x400b3a <.text+0x8ba>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400b31 <.text+0x8b1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400b35 <.text+0x8b5>
               	andb	%ch, 0x74(%rax)
               	je	0x400b45 <.text+0x8c5>
               	jae	0x400b11 <.text+0x891>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400b4d <.text+0x8cd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400bbd <exit>
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
               	jbe	0x400b6b <.text+0x8eb>
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
               	jae	0x400bf2 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400be9 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400bed <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x400bfd <exit+0x40>
               	jae	0x400bc9 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400c05 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf523(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xf525(%rip)           # 0x4100e8
