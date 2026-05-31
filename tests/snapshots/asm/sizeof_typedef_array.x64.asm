
sizeof_typedef_array.x64:	file format elf64-x86-64

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
               	movl	$0x1, %eax
               	retq
               	movl	$0x28, %r9d
               	movslq	%r9d, %r9
               	cmpq	$0x28, %r9
               	je	0x400273 <.text+0x53>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x40028d <.text+0x6d>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4002a7 <.text+0x87>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4002c1 <.text+0xa1>
               	movl	$0x5, %r9d
               	movq	%r9, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4002db <.text+0xbb>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	retq
               	xorq	%rax, %rax
               	retq
