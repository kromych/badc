
typedef_shadowed_by_parameter_name.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	0x400253 <.text+0x33>
               	movl	$0xb, %eax
               	retq
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	0x40026f <.text+0x4f>
               	movl	$0xc, %eax
               	retq
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	0x40028b <.text+0x6b>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
