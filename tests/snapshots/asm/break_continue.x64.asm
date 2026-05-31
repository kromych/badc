
break_continue.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	movl	%r11d, -0x8(%rbp)
               	jmp	0x400252 <.text+0x32>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	0x400297 <.text+0x77>
               	jmp	0x400281 <.text+0x61>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400252 <.text+0x32>
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x5, %r8
               	jne	0x4002a9 <.text+0x89>
               	jmp	0x4002a4 <.text+0x84>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400297 <.text+0x77>
               	movslq	-0x8(%rbp), %r8
               	movl	$0x2, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r11
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %r11
               	jne	0x4002d7 <.text+0xb7>
               	jmp	0x400268 <.text+0x48>
               	movslq	-0x10(%rbp), %r11
               	movslq	-0x8(%rbp), %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400268 <.text+0x48>
               	addb	%al, (%rax)
