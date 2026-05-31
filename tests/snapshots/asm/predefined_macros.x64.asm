
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
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	subq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x1, %r9
               	je	0x400275 <.text+0x55>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	je	0x400293 <.text+0x73>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe36(%rip), %r9       # 0x4100d0
               	movq	%r9, %rax
               	addq	$0x3, %rax
               	movzbq	(%rax), %r8
               	xorq	$0x20, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x4002d3 <.text+0xb3>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	addq	$0x6, %r8
               	movzbq	(%r8), %rax
               	xorq	$0x20, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400310 <.text+0xf0>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0xb, %r9
               	movzbq	(%r9), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400343 <.text+0x123>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd92(%rip), %rax      # 0x4100dc
               	movq	%rax, %r9
               	addq	$0x2, %r9
               	movzbq	(%r9), %r8
               	xorq	$0x3a, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400387 <.text+0x167>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r8
               	addq	$0x5, %r8
               	movzbq	(%r8), %r9
               	xorq	$0x3a, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4003c4 <.text+0x1a4>
               	movl	$0x7, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addq	$0x8, %rax
               	movzbq	(%rax), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4003f3 <.text+0x1d3>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfceb(%rip), %r9       # 0x4100e5
               	movzbq	(%r9), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	jne	0x400426 <.text+0x206>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
