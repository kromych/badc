
typedef_array_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400325 <.text+0x105>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x10, %r8
               	jge	0x40029f <.text+0x7f>
               	jmp	0x400280 <.text+0x60>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x3, %r8
               	movq	%r11, %rsi
               	addq	%r8, %rsi
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	movq	%r8, (%rsi)
               	jmp	0x40026a <.text+0x4a>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	0x4002c9 <.text+0xa9>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x10, %r9
               	jge	0x400318 <.text+0xf8>
               	jmp	0x4002f5 <.text+0xd5>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	0x4002c9 <.text+0xa9>
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %rdi
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x3, %r8
               	movq	%r11, %rsi
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	addq	%r8, %rdi
               	movq	%rdi, (%r9)
               	jmp	0x4002df <.text+0xbf>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x108(%rbp)
               	jmp	0x40034d <.text+0x12d>
               	movslq	-0x108(%rbp), %r11
               	cmpq	$0x10, %r11
               	jge	0x4003a3 <.text+0x183>
               	jmp	0x40037f <.text+0x15f>
               	leaq	-0x108(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x40034d <.text+0x12d>
               	leaq	-0x80(%rbp), %r11
               	movslq	-0x108(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r11
               	addq	$0x1, %r8
               	movq	%r8, (%r11)
               	jmp	0x400366 <.text+0x146>
               	leaq	-0x100(%rbp), %rbx
               	leaq	-0x80(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	leaq	-0x100(%rbp), %r14
               	movq	%r14, %rdi
               	callq	0x4002ab <.text+0x8b>
               	movl	$0x110, %r14d           # imm = 0x110
               	movslq	%r14d, %r14
               	movl	$0x2, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	cmpq	%r14, %rax
               	je	0x400414 <.text+0x1f4>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %r14
               	cmpq	$0x1, %r14
               	je	0x40044d <.text+0x22d>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %r14
               	addq	$0x78, %r14
               	movq	(%r14), %rax
               	cmpq	$0x10, %rax
               	je	0x40048e <.text+0x26e>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
