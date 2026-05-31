
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400490 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4003cb <.text+0x8b>
               	leaq	0xfd72(%rip), %rdi      # 0x410110
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
               	leaq	0xfd4f(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd3d(%rip), %rsi      # 0x41012e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd2c(%rip), %r9       # 0x410135
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
               	callq	0x4008c7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40045c <.text+0x11c>
               	leaq	0xfccc(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40045c <.text+0x11c>
               	leaq	0xfcad(%rip), %r12      # 0x410110
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %r9d
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4008cd <malloc>
               	movq	%rax, %r8
               	movq	%r8, (%rbx)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r8
               	cmpq	$0x0, %r8
               	jne	0x4004fe <.text+0x1be>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x40050a <.text+0x1ca>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0x4, %r12
               	jge	0x400546 <.text+0x206>
               	jmp	0x40053b <.text+0x1fb>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%r12)
               	jmp	0x40050a <.text+0x1ca>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	jmp	0x400552 <.text+0x212>
               	xorq	%r12, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x4005d3 <.text+0x293>
               	movslq	-0x18(%rbp), %rbx
               	cmpq	$0x8, %rbx
               	jge	0x4005ce <.text+0x28e>
               	jmp	0x400581 <.text+0x241>
               	leaq	-0x18(%rbp), %rbx
               	movslq	(%rbx), %r8
               	movq	%r8, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rbx)
               	jmp	0x400552 <.text+0x212>
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r8
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rbx
               	shlq	$0x4, %rbx
               	movq	%r8, %rdi
               	addq	%rbx, %rdi
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %r8
               	shlq	$0x1, %r8
               	movq	%rdi, %rsi
               	addq	%r8, %rsi
               	movl	$0x64, %r8d
               	imulq	%r12, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %r12
               	addq	%rbx, %r12
               	movslq	%r12d, %r12
               	movswq	%r12w, %r12
               	movw	%r12w, (%rsi)
               	jmp	0x400568 <.text+0x228>
               	jmp	0x400520 <.text+0x1e0>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0x4, %r12
               	jge	0x40060f <.text+0x2cf>
               	jmp	0x400604 <.text+0x2c4>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %r8
               	movq	%r8, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r12)
               	jmp	0x4005d3 <.text+0x293>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x18(%rbp)
               	jmp	0x400642 <.text+0x302>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %r8
               	movabsq	$-0x1, %rdi
               	movw	%di, (%r8)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rdi
               	movswq	(%rdi), %r12
               	cmpq	$-0x1, %r12
               	je	0x400738 <.text+0x3f8>
               	jmp	0x400715 <.text+0x3d5>
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0x8, %rsi
               	jge	0x4006c6 <.text+0x386>
               	jmp	0x400671 <.text+0x331>
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %r8
               	movq	%r8, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rsi)
               	jmp	0x400642 <.text+0x302>
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %r8
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rsi
               	shlq	$0x4, %rsi
               	movq	%r8, %rbx
               	addq	%rsi, %rbx
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %r8
               	shlq	$0x1, %r8
               	movq	%rbx, %rdi
               	addq	%r8, %rdi
               	movswq	(%rdi), %r8
               	movl	$0x64, %edi
               	imulq	%r12, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r12
               	addq	%rsi, %r12
               	movslq	%r12d, %r12
               	movswq	%r12w, %r12
               	cmpq	%r12, %r8
               	je	0x400710 <.text+0x3d0>
               	jmp	0x4006cb <.text+0x38b>
               	jmp	0x4005e9 <.text+0x2a9>
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r12
               	addq	$0xa, %r12
               	movslq	%r12d, %r12
               	movslq	-0x18(%rbp), %rdi
               	movq	%r12, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400658 <.text+0x318>
               	movl	$0x63, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4008d3 <free>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	leaq	0xfa0a(%rip), %r12      # 0x410160
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4008d9 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4007bf <.text+0x47f>
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
               	jae	0x400846 <.text+0x506>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x40083d <.text+0x4fd>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400841 <.text+0x501>
               	andb	%ch, 0x74(%rax)
               	je	0x400851 <.text+0x511>
               	jae	0x40081d <.text+0x4dd>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400859 <.text+0x519>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4008df <exit>
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
               	jbe	0x40087b <.text+0x53b>
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
               	jae	0x400902 <exit+0x23>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4008f9 <exit+0x1a>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4008fd <exit+0x1e>
               	andb	%ch, 0x74(%rax)
               	je	0x40090d <exit+0x2e>
               	jae	0x4008d9 <printf>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400915 <exit+0x36>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf813(%rip)           # 0x4100e0

<malloc>:
               	jmpq	*0xf815(%rip)           # 0x4100e8

<free>:
               	jmpq	*0xf817(%rip)           # 0x4100f0

<printf>:
               	jmpq	*0xf819(%rip)           # 0x4100f8

<exit>:
               	jmpq	*0xf81b(%rip)           # 0x410100
