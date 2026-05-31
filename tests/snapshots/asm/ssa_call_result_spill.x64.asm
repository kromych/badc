
ssa_call_result_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400315 <.text+0xf5>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	movq	%r9, %rcx
               	shrq	%cl, %r8
               	movl	$0x40, %edi
               	movq	%rdi, %rsi
               	subq	%r9, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdi
               	movq	%rsi, %rcx
               	shlq	%cl, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movq	%rdx, %r8
               	movq	%r11, %rdi
               	andq	%r9, %rdi
               	movq	%r11, %r9
               	xorq	$-0x1, %r9
               	movq	%r9, %r11
               	andq	%r8, %r11
               	movq	%rdi, %rax
               	xorq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movl	$0xe, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r14
               	movl	$0x12, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	movq	%r14, %r12
               	xorq	%rdi, %r12
               	movl	$0x29, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r14
               	movq	%r12, %r15
               	xorq	%r14, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x100, %r11d           # imm = 0x100
               	movq	%r11, -0x8(%rbp)
               	movl	$0x200, %r9d            # imm = 0x200
               	movq	%r9, -0x10(%rbp)
               	movl	$0x400, %r11d           # imm = 0x400
               	movq	%r11, -0x18(%rbp)
               	movl	$0x800, %r9d            # imm = 0x800
               	movq	%r9, -0x20(%rbp)
               	movl	$0x1000, %r11d          # imm = 0x1000
               	movq	%r11, -0x28(%rbp)
               	movl	$0x2000, %r9d           # imm = 0x2000
               	movq	%r9, -0x30(%rbp)
               	movl	$0x4000, %r11d          # imm = 0x4000
               	movq	%r11, -0x38(%rbp)
               	movl	$0x8000, %r9d           # imm = 0x8000
               	movq	%r9, -0x40(%rbp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x48(%rbp)
               	jmp	0x40038f <.text+0x16f>
               	movslq	-0x48(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	0x400466 <.text+0x246>
               	jmp	0x4003be <.text+0x19e>
               	leaq	-0x48(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40038f <.text+0x16f>
               	movq	-0x28(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	0x40028a <.text+0x6a>
               	movq	%rax, %r12
               	movq	-0x28(%rbp), %r14
               	movq	-0x30(%rbp), %rbx
               	movq	-0x38(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	0x400264 <.text+0x44>
               	movq	%rax, %rsi
               	movq	%r12, %r15
               	addq	%rsi, %r15
               	movq	-0x40(%rbp), %rsi
               	movq	%r15, %r12
               	addq	%rsi, %r12
               	movq	%r12, -0x50(%rbp)
               	movq	-0x8(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x40028a <.text+0x6a>
               	movq	%rax, %r12
               	movq	%r12, -0x58(%rbp)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	movq	-0x30(%rbp), %r12
               	movq	%r12, -0x38(%rbp)
               	movq	-0x28(%rbp), %r14
               	movq	%r14, -0x30(%rbp)
               	movq	-0x20(%rbp), %r12
               	movq	-0x50(%rbp), %r14
               	movq	%r12, %r15
               	addq	%r14, %r15
               	movq	%r15, -0x28(%rbp)
               	movq	-0x18(%rbp), %r12
               	movq	%r12, -0x20(%rbp)
               	movq	-0x10(%rbp), %r15
               	movq	%r15, -0x18(%rbp)
               	movq	-0x8(%rbp), %r12
               	movq	%r12, -0x10(%rbp)
               	movq	-0x58(%rbp), %r15
               	movq	%r14, %r12
               	addq	%r15, %r12
               	movq	%r12, -0x8(%rbp)
               	jmp	0x4003a5 <.text+0x185>
               	movq	-0x8(%rbp), %r12
               	movabsq	$0x30a55d88de61bb19, %r11 # imm = 0x30A55D88DE61BB19
               	movq	%r12, %r15
               	cmpq	%r11, %r12
               	je	0x4004a8 <.text+0x288>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	-0x40(%rbp), %r15
               	movabsq	$0x440000080000c800, %r11 # imm = 0x440000080000C800
               	movq	%r15, %r12
               	cmpq	%r11, %r15
               	je	0x4004ea <.text+0x2ca>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400547 <.text+0x327>
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
               	jae	0x4005ce <.text+0x3ae>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4005c5 <.text+0x3a5>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4005c9 <.text+0x3a9>
               	andb	%ch, 0x74(%rax)
               	je	0x4005d9 <.text+0x3b9>
               	jae	0x4005a5 <.text+0x385>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005e1 <.text+0x3c1>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
		...
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400657 <exit>
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
               	jbe	0x40060b <.text+0x3eb>
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
               	jae	0x400692 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400689 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40068d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40069d <exit+0x46>
               	jae	0x400669 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4006a5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfa63(%rip)           # 0x4100c0
