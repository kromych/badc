
predefined_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xf, %r11d
               	movl	$0x10, %r9d
               	movslq	%r9d, %r8
               	movslq	%r11d, %r9
               	movq	%r8, %r11
               	subq	%r9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400278 <.text+0x58>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	0x400296 <.text+0x76>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe33(%rip), %r9       # 0x4100d0
               	movq	%r9, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x20, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x4002dd <.text+0xbd>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	addq	$0x6, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x20, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x40031d <.text+0xfd>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	addq	$0xb, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x40034e <.text+0x12e>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd87(%rip), %r9       # 0x4100dc
               	movq	%r9, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x3a, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400395 <.text+0x175>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x3a, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x4003d5 <.text+0x1b5>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	je	0x400406 <.text+0x1e6>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcd8(%rip), %r9       # 0x4100e5
               	movzbq	(%r9), %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	cmpq	$0x0, %r9
               	jne	0x400439 <.text+0x219>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
