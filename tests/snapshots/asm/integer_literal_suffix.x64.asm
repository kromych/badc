
integer_literal_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	subq	$0x1, %r11
               	movabsq	$0xfffffffff, %r10      # imm = 0xFFFFFFFFF
               	cmpq	%r10, %r11
               	je	0x400274 <.text+0x54>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x24, %r11d
               	movl	$0x1, %eax
               	movslq	%r11d, %r11
               	movq	%r11, %rcx
               	shlq	%cl, %rax
               	subq	$0x1, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	0x4002b4 <.text+0x94>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	addq	$0x1, %rax
               	movabsq	$0x12345678a, %r11      # imm = 0x12345678A
               	cmpq	%r11, %rax
               	je	0x4002ea <.text+0xca>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x40(%rbp)
               	cmpq	$0x0, %r11
               	je	0x400331 <.text+0x111>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %r8
               	cmpq	%r11, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x40(%rbp)
               	jmp	0x400331 <.text+0x111>
               	movq	-0x40(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400354 <.text+0x134>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$-0x1, %rax
               	je	0x400373 <.text+0x153>
               	movl	$0xf, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	addq	$0x1, %rax
               	cmpq	$0x0, %rax
               	je	0x4003a3 <.text+0x183>
               	movl	$0x10, %r8d
               	movq	%r8, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
