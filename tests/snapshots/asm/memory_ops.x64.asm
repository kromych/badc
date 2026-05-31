
memory_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400307 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xa, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4005c7 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4005c7 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x41, %r15d
               	movl	$0x9, %r14d
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x20(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4005cd <memset>
               	movq	%rax, %rsi
               	movq	0x20(%rsp), %rsi
               	addq	$0x9, %rsi
               	xorq	%r12, %r12
               	movb	%r12b, (%rsi)
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4005cd <memset>
               	movq	%rax, %rdx
               	movq	0x28(%rsp), %rdx
               	addq	$0x9, %rdx
               	movb	%r12b, (%rdx)
               	movq	%rbx, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	0x4005d3 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x4003f4 <.text+0x104>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rbx
               	addq	$0x5, %rbx
               	movl	$0x42, %r14d
               	movb	%r14b, (%rbx)
               	movl	$0xa, %r15d
               	movq	%r15, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	0x4005d3 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x40045e <.text+0x16e>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4004bb <.text+0x1cb>
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
               	jae	0x400542 <.text+0x252>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400539 <.text+0x249>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40053d <.text+0x24d>
               	andb	%ch, 0x74(%rax)
               	je	0x40054d <.text+0x25d>
               	jae	0x400519 <.text+0x229>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400555 <.text+0x265>
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
               	callq	0x4005d9 <exit>
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
               	jbe	0x40057b <.text+0x28b>
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
               	jae	0x400602 <exit+0x29>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005f9 <exit+0x20>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005fd <exit+0x24>
               	andb	%ch, 0x74(%rax)
               	je	0x40060d <exit+0x34>
               	jae	0x4005d9 <exit>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400615 <exit+0x3c>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<malloc>:
               	jmpq	*0xfb03(%rip)           # 0x4100d0

<memset>:
               	jmpq	*0xfb05(%rip)           # 0x4100d8

<memcmp>:
               	jmpq	*0xfb07(%rip)           # 0x4100e0

<exit>:
               	jmpq	*0xfb09(%rip)           # 0x4100e8
