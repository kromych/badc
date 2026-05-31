
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
               	jge	0x400294 <.text+0x74>
               	jmp	0x40027e <.text+0x5e>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x400252 <.text+0x32>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x5, %r11
               	jne	0x4002a6 <.text+0x86>
               	jmp	0x4002a1 <.text+0x81>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400294 <.text+0x74>
               	movslq	-0x8(%rbp), %r8
               	movl	$0x2, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %r8
               	jne	0x4002d1 <.text+0xb1>
               	jmp	0x400268 <.text+0x48>
               	movslq	-0x10(%rbp), %r11
               	movslq	-0x8(%rbp), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400268 <.text+0x48>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
