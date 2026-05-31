
code_as_data.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40023d <.text+0x1d>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x7, %eax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x18(%rip), %r11       # 0x400237 <.text+0x17>
               	movslq	(%r11), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
