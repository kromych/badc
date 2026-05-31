
global_initializer_int.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	leaq	0xfe92(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %r9
               	cmpq	$0x2a, %r9
               	je	0x400264 <.text+0x34>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe7d(%rip), %r9       # 0x4100e8
               	movslq	(%r9), %rax
               	cmpq	$0x63, %rax
               	je	0x400285 <.text+0x55>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe54(%rip), %rax      # 0x4100e0
               	movslq	(%rax), %r9
               	leaq	0xfe52(%rip), %rax      # 0x4100e8
               	movslq	(%rax), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
