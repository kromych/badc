
thread_local_per_thread.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400389 <.text+0x99>
               	movq	%rax, %rdi
               	callq	*0xfde9(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x400335 <.text+0x45>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movl	$0x63, %eax
               	movl	%eax, (%r11)
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x63, %rax
               	je	0x400374 <.text+0x84>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400627 <dlopen>
               	movq	%rax, %r14
               	leaq	0xfd28(%rip), %r15      # 0x410108
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40062d <dlsym>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xfd1b(%rip), %r15      # 0x410117
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40062d <dlsym>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %r14
               	leaq	-0x110(%rip), %r15      # 0x400307 <.text+0x17>
               	movq	0x28(%rsp), %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	-0x20(%rbp), %rbx
               	leaq	-0x28(%rbp), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	-0x28(%rbp), %r15
               	cmpq	$0x63, %r15
               	je	0x40047e <.text+0x18e>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r14
               	subq	$0x8, %r14
               	movslq	(%r14), %r15
               	cmpq	$0x1, %r15
               	je	0x4004c6 <.text+0x1d6>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400523 <.text+0x233>
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
               	jae	0x4005aa <.text+0x2ba>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005a1 <.text+0x2b1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005a5 <.text+0x2b5>
               	andb	%ch, 0x74(%rax)
               	je	0x4005b5 <.text+0x2c5>
               	jae	0x400581 <.text+0x291>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005bd <.text+0x2cd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400633 <exit>
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
               	jbe	0x4005db <.text+0x2eb>
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
               	jae	0x400662 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400659 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40065d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x40066d <exit+0x3a>
               	jae	0x400639 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400675 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlopen>:
               	jmpq	*0xfab3(%rip)           # 0x4100e0

<dlsym>:
               	jmpq	*0xfab5(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xfab7(%rip)           # 0x4100f0
