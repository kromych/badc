
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400248 <.text+0x28>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x64, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x1, %r9d
               	movslq	%r9d, %r11
               	cmpq	$0x0, %r11
               	jne	0x4002bb <.text+0x9b>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x7b(%rip), %r15       # 0x400237 <.text+0x17>
               	movq	%r15, -0x30(%rbp)
               	jmp	0x40030d <.text+0xed>
               	leaq	-0x8b(%rip), %rbx       # 0x400237 <.text+0x17>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movl	%r15d, (%r12)
               	leaq	-0x8(%rbp), %r14
               	movslq	(%r14), %r12
               	movl	$0x2, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r12, %r15
               	addq	%rsi, %r15
               	movl	%r15d, (%r14)
               	jmp	0x4002ab <.text+0x8b>
               	movq	-0x30(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x40035a <.text+0x13a>
               	jmp	0x40032f <.text+0x10f>
               	xorq	%r15, %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	0x40030d <.text+0xed>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r15
               	movl	$0x3, %r12d
               	movq	-0x30(%rbp), %r14
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r15, %r14
               	addq	%rsi, %r14
               	movl	%r14d, (%rbx)
               	jmp	0x400323 <.text+0x103>
               	leaq	-0x12a(%rip), %r14      # 0x400237 <.text+0x17>
               	movq	%r14, -0x48(%rbp)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r15
               	leaq	-0x48(%rbp), %rbx
               	movq	(%rbx), %r14
               	movl	$0x4, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %rsi
               	movq	%r15, %rbx
               	addq	%rsi, %rbx
               	movl	%ebx, (%r12)
               	movslq	-0x8(%rbp), %rsi
               	cmpq	$0x19a, %rsi            # imm = 0x19A
               	jne	0x4003ac <.text+0x18c>
               	xorq	%rsi, %rsi
               	movq	%rsi, -0x60(%rbp)
               	jmp	0x4003ba <.text+0x19a>
               	movl	$0x2, %esi
               	movq	%rsi, -0x60(%rbp)
               	jmp	0x4003ba <.text+0x19a>
               	movq	-0x60(%rbp), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x40041b <.text+0x1fb>
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
               	jae	0x4004a2 <.text+0x282>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400499 <.text+0x279>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40049d <.text+0x27d>
               	andb	%ch, 0x74(%rax)
               	je	0x4004ad <.text+0x28d>
               	jae	0x400479 <.text+0x259>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004b5 <.text+0x295>
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
               	callq	0x400527 <exit>
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
               	jbe	0x4004db <.text+0x2bb>
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
               	jae	0x400562 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400559 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40055d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40056d <exit+0x46>
               	jae	0x400539 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400575 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb93(%rip)           # 0x4100c0
