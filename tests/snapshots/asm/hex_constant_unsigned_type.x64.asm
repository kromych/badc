
hex_constant_unsigned_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movabsq	$-0x1, %r11
               	movslq	%r11d, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	0x400269 <.text+0x49>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	0x400291 <.text+0x71>
               	movl	$0x2, %eax
               	retq
               	movslq	%r11d, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	0x4002b8 <.text+0x98>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
