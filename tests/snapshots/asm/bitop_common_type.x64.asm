
bitop_common_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x14006f000, %r11      # imm = 0x14006F000
               	xorq	%r9, %r9
               	movq	%r11, %r8
               	orq	%r9, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %r8
               	xorq	$-0x1, %r8
               	andq	%r11, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	xorq	%r9, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f001, %r10      # imm = 0x14006F001
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x14006f001, %r8       # imm = 0x14006F001
               	subq	$0x1, %r8
               	orq	$0xf, %r8
               	addq	$0x1, %r8
               	movabsq	$0x14006f010, %r10      # imm = 0x14006F010
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movabsq	$0x14006f000, %r10      # imm = 0x14006F000
               	cmpq	%r10, %r8
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	orq	%r9, %r11
               	movabsq	$0x100000000, %r10      # imm = 0x100000000
               	cmpq	%r10, %r11
               	seta	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
