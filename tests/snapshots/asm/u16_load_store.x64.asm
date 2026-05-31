
u16_load_store.x64:	file format elf64-x86-64

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
               	callq	0x4007e7 <dlsym>
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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	0xfd22(%rip), %r9       # 0x410156
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movl	$0xa, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4007ed <memset>
               	movq	%rax, %rdi
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %r14
               	addq	$0x2, %r14
               	movl	$0x4241, %edi           # imm = 0x4241
               	movw	%di, (%r14)
               	leaq	-0x20(%rbp), %r12
               	movzbq	(%r12), %rdi
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x40(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x4004ec <.text+0x22c>
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %r12
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	$0x0, %rdi
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x40(%rbp)
               	jmp	0x4004ec <.text+0x22c>
               	movq	-0x40(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x40051f <.text+0x25f>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r12
               	movq	%r12, %rdi
               	xorq	$0x41, %rdi
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x48(%rbp)
               	cmpq	$0x0, %rdi
               	jne	0x4005a1 <.text+0x2e1>
               	leaq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %r12
               	movq	%r12, %rdi
               	xorq	$0x42, %rdi
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	0x4005a1 <.text+0x2e1>
               	movq	-0x48(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x4005d5 <.text+0x315>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %r12
               	addq	$0x4, %r12
               	movzbq	(%r12), %rdi
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	je	0x400621 <.text+0x361>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdi, %r12
               	addq	$0x1, %r12
               	movzwq	(%r12), %rdi
               	movq	%rdi, %r12
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	movq	%r12, %rdi
               	xorq	$0x4342, %rdi           # imm = 0x4342
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	je	0x400681 <.text+0x3c1>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x4006db <.text+0x41b>
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
               	jae	0x400762 <.text+0x4a2>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400759 <.text+0x499>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40075d <.text+0x49d>
               	andb	%ch, 0x74(%rax)
               	je	0x40076d <.text+0x4ad>
               	jae	0x400739 <.text+0x479>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400775 <.text+0x4b5>
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
               	callq	0x4007f3 <exit>
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
               	jbe	0x40079b <.text+0x4db>
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
               	jae	0x400822 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400819 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40081d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x40082d <exit+0x3a>
               	jae	0x4007f9 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400835 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf8f3(%rip)           # 0x4100e0

<memset>:
               	jmpq	*0xf8f5(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf8f7(%rip)           # 0x4100f0
