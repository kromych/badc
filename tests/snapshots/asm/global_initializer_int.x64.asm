
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
               	leaq	0xfe7d(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %rax
               	cmpq	$0x63, %rax
               	je	0x400281 <.text+0x51>
               	movl	$0x2, %eax
               	retq
               	leaq	0xfe58(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %rax
               	leaq	0xfe56(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %r8
               	movq	%rax, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %rax
               	retq
