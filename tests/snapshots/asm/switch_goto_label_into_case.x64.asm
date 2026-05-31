
switch_goto_label_into_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40031f <.text+0xff>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	jmp	0x4002ac <.text+0x8c>
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x14, %r8d
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x5, %r11
               	setge	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x8(%rbp)
               	cmpq	$0x0, %r8
               	je	0x4002fd <.text+0xdd>
               	jmp	0x4002e5 <.text+0xc5>
               	cmpq	$0x1, %r11
               	je	0x400259 <.text+0x39>
               	cmpq	$0x2, %r11
               	je	0x400267 <.text+0x47>
               	cmpq	$0x3, %r11
               	je	0x400279 <.text+0x59>
               	cmpq	$0x4, %r11
               	je	0x400279 <.text+0x59>
               	jmp	0x400287 <.text+0x67>
               	cmpq	$0x8, %r11
               	setle	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	jmp	0x4002fd <.text+0xdd>
               	movq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x400313 <.text+0xf3>
               	jmp	0x400279 <.text+0x59>
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0xa, %rax
               	je	0x40036a <.text+0x14a>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x14, %rax
               	je	0x4003a3 <.text+0x183>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1e, %rax
               	je	0x4003da <.text+0x1ba>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1e, %rax
               	je	0x400413 <.text+0x1f3>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1e, %rax
               	je	0x40044a <.text+0x22a>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1e, %rax
               	je	0x400483 <.text+0x263>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1e, %rax
               	je	0x4004ba <.text+0x29a>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x4004f0 <.text+0x2d0>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x400527 <.text+0x307>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
