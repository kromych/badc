
tentative_definitions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x3, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe7d(%rip), %r11      # 0x4100d8
               	movslq	(%r11), %rax
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rdi
               	movq	%rax, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	addq	$0x8, %rdi
               	movslq	(%rdi), %r11
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x6, %rdi
               	je	0x40029d <.text+0x7d>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
