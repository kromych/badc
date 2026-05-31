
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
               	movl	$0x200, %r9d            # imm = 0x200
               	movslq	%r9d, %r9
               	cmpq	$0x200, %r9             # imm = 0x200
               	je	0x400273 <.text+0x53>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	movl	$0x200, %eax            # imm = 0x200
               	movslq	%eax, %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	je	0x40028e <.text+0x6e>
               	movl	$0xd, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
