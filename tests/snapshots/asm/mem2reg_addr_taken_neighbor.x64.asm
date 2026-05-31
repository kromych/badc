
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ac <.text+0x8c>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	movslq	%r8d, %r8
               	leaq	-0x8(%rbp), %r11
               	movl	%r9d, -0x20(%rbp)
               	jmp	0x400263 <.text+0x43>
               	movslq	-0x20(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x40029f <.text+0x7f>
               	movslq	(%r11), %r9
               	movslq	%r8d, %rdi
               	movq	%r9, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%r11)
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x20(%rbp)
               	jmp	0x400263 <.text+0x43>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x7, %ebx
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
