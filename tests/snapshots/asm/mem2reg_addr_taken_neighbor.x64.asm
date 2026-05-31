
mem2reg_addr_taken_neighbor.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002a4 <.text+0x84>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	shlq	$0x1, %r11
               	movslq	%r11d, %r11
               	leaq	-0x8(%rbp), %r8
               	movl	%r9d, -0x20(%rbp)
               	jmp	0x400260 <.text+0x40>
               	movslq	-0x20(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400297 <.text+0x77>
               	movslq	(%r8), %rdi
               	movslq	%r11d, %r9
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r8)
               	movslq	-0x20(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x20(%rbp)
               	jmp	0x400260 <.text+0x40>
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
