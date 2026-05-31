
global_initializer_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	leaq	0xfe9a(%rip), %r11      # 0x4100e8
               	movq	(%r11), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x7, %r11
               	je	0x400267 <.text+0x37>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe72(%rip), %r11      # 0x4100e0
               	movl	$0xb, %eax
               	movl	%eax, (%r11)
               	leaq	0xfe6b(%rip), %r8       # 0x4100e8
               	movq	(%r8), %rax
               	movslq	(%rax), %r8
               	cmpq	$0xb, %r8
               	je	0x400296 <.text+0x66>
               	movl	$0x2, %eax
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	retq
               	addb	%al, (%rax)
