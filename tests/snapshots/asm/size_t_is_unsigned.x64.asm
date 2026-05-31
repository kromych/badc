
size_t_is_unsigned.x64:	file format elf64-x86-64

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
               	xorq	%r11, %r11
               	movq	%r11, %r9
               	xorq	$-0x1, %r9
               	movl	$0x9, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %r8
               	jne	0x400280 <.text+0x60>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %r11d
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	popq	%rdx
               	movabsq	$0x1c71c71c71c71c71, %r10 # imm = 0x1C71C71C71C71C71
               	movq	%rax, %r11
               	cmpq	%r10, %rax
               	je	0x4002b5 <.text+0x95>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x3e8, %r9             # imm = 0x3E8
               	jae	0x4002d0 <.text+0xb0>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0x5, %r11d
               	movslq	%r11d, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	%rdi, %r11
               	jae	0x40031b <.text+0xfb>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	movq	%r11, -0x28(%rbp)
               	jmp	0x40032d <.text+0x10d>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r11
               	movq	%r11, -0x28(%rbp)
               	jmp	0x40032d <.text+0x10d>
               	movq	-0x28(%rbp), %r11
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	%r11, %rdi
               	je	0x40035d <.text+0x13d>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
