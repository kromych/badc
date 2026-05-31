
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
               	xorq	$-0x1, %r11
               	movl	$0x9, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %r8
               	jne	0x400280 <.text+0x60>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %r8d
               	movq	%r8, %r10
               	pushq	%rdx
               	movq	%r11, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	movabsq	$0x1c71c71c71c71c71, %r10 # imm = 0x1C71C71C71C71C71
               	cmpq	%r10, %rax
               	je	0x4002b9 <.text+0x99>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x3e8, %r11            # imm = 0x3E8
               	jae	0x4002d8 <.text+0xb8>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movl	$0x5, %r8d
               	movslq	%r8d, %r8
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	%r11, %r8
               	jae	0x400325 <.text+0x105>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movq	%rdi, -0x28(%rbp)
               	jmp	0x400337 <.text+0x117>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movq	%r11, -0x28(%rbp)
               	jmp	0x400337 <.text+0x117>
               	movq	-0x28(%rbp), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	cmpq	%rax, %r11
               	je	0x400364 <.text+0x144>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
