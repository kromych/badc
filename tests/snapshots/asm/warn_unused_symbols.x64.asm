
warn_unused_symbols.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40024b <.text+0x2b>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x5, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
